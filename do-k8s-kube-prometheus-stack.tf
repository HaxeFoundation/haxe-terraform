locals {
  do-grafana = {
    hostnames = ["do-grafana.haxe.org"]
    user      = "admin"
    password  = random_password.grafana-admin-pw.result
  }

  do-kube-prometheus-stack = {
    version = "92.21.2"
    grafana-additional-datasources = [{
      "name" : "Loki",
      # Same uid as the datasource previously provisioned by loki-stack, to keep existing links working.
      "uid" : "P8E80F9AEF21F6940",
      "type" : "loki",
      "access" : "proxy",
      "url" : local.do-loki.url,
    }]
  }
}

output "grafana" {
  value     = local.do-grafana
  sensitive = true
}

resource "random_password" "grafana-admin-pw" {
  length  = 32
  special = false
}

resource "kubernetes_secret_v1" "do-grafana-admin" {
  provider = kubernetes.do
  metadata {
    name      = "grafana-admin"
    namespace = kubernetes_namespace_v1.do-monitoring.metadata[0].name
  }

  data = {
    admin-user     = local.do-grafana.user
    admin-password = local.do-grafana.password
  }
}

# kubectl -n monitoring create secret generic grafana-github-oauth-client-secret --from-literal=GRAFANA_GITHUB_OAUTH_CLIENT_SECRET=FIXME
data "kubernetes_secret_v1" "do-grafana-github-oauth-client-secret" {
  provider = kubernetes.do
  metadata {
    name      = "grafana-github-oauth-client-secret"
    namespace = kubernetes_namespace_v1.do-monitoring.metadata[0].name
  }
}

# earthly +kube-prometheus-stack.crds
module "do-kube-prometheus-stack-crds" {
  source = "./kube-prometheus-stack.crds"
  providers = {
    kubernetes = kubernetes.do
  }
}

resource "helm_release" "do-prometheus" {
  provider = helm.do

  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace_v1.do-monitoring.metadata[0].name
  version    = local.do-kube-prometheus-stack.version
  values = [
    yamlencode({
      # https://github.com/aws/containers-roadmap/issues/657
      "kubeProxy" : {
        "enabled" : false,
      },
      "kubeScheduler" : {
        "enabled" : false,
      },
      "kubeControllerManager" : {
        "enabled" : false,
      },

      "prometheus" : {
        "enabled" : true,
        "prometheusSpec" : {
          # https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#prometheusioscrape
          "podMonitorSelectorNilUsesHelmValues" : false,
          "serviceMonitorSelectorNilUsesHelmValues" : false,

          "storageSpec" : {
            "volumeClaimTemplate" : {
              "metadata" : {
                "name" : "prometheus"
              },
              "spec" : {
                "storageClassName" : "do-block-storage",
                "accessModes" : [
                  "ReadWriteOnce"
                ],
                "resources" : {
                  "requests" : {
                    "storage" : "30Gi"
                  }
                }
              }
            }
          }
        }
      },

      # https://github.com/grafana/helm-charts/blob/main/charts/grafana/values.yaml
      "grafana" : {
        "ingress" : {
          "enabled" : true,
          "hosts" : local.do-grafana.hostnames
          "pathType" : "Prefix",
          "annotations" : local.do-cert-manager.ingress_annotations,
          "tls" : [{
            "hosts" : local.do-grafana.hostnames,
            "secretName" : "grafana-tls"
          }]
        },
        "persistence" : {
          "enabled" : true,
          "size" : "10Gi",
        },
        # The PVC is ReadWriteOnce, so a rolling update can deadlock (Multi-Attach error)
        # if the new pod is scheduled onto another node.
        "deploymentStrategy" : {
          "type" : "Recreate",
        },
        # Memory request based on the measured usage of Grafana 13 (Nov 2026)
        # with the unused plugins disabled (see "disable_plugins" below).
        # Without requests, the pod is BestEffort: invisible to the scheduler and first to be evicted.
        "resources" : {
          "requests" : {
            "memory" : "384Mi",
          },
        },
        # Load the datasources and dashboards (ConfigMaps with the grafana_datasource / grafana_dashboard label)
        # once at startup with init containers, instead of keeping 2 sidecars (~80Mi each) watching them.
        # Changes are picked up when the pod restarts; see the "checksum/provisioning" pod annotation.
        # LIST: load once and exit (WATCH would never finish, blocking the pod in Init).
        # skipReload: Grafana isn't running yet during init, and reads the files when it starts.
        "sidecar" : {
          "dashboards" : {
            "initDashboards" : true,
            "watchMethod" : "LIST",
            "skipReload" : true,
          },
          "datasources" : {
            "initDatasources" : true,
            "watchMethod" : "LIST",
            "skipReload" : true,
          },
          "resources" : {
            "requests" : {
              "memory" : "96Mi",
            },
          },
        },
        # Restart Grafana when the provisioned datasources or dashboards may have changed:
        # the datasources are defined below, and the dashboards are bundled with the chart.
        "podAnnotations" : {
          "checksum/provisioning" : sha256(jsonencode([
            local.do-kube-prometheus-stack.version,
            local.do-kube-prometheus-stack.grafana-additional-datasources,
          ])),
        },
        "adminPassword" : random_password.grafana-admin-pw.result,
        "admin" : {
          "existingSecret" : kubernetes_secret_v1.do-grafana-admin.metadata[0].name,
        },
        "env" : {
          "HOSTNAME" : local.do-grafana.hostnames[0],
        },
        "envValueFrom" : {
          "GRAFANA_GITHUB_OAUTH_CLIENT_SECRET" : {
            "secretKeyRef" : {
              "name" : data.kubernetes_secret_v1.do-grafana-github-oauth-client-secret.metadata[0].name,
              "key" : "GRAFANA_GITHUB_OAUTH_CLIENT_SECRET",
            },
          },
        },
        "grafana.ini" : {
          "server" : {
            # https://grafana.com/docs/grafana/latest/administration/configuration/#root_url
            "root_url" : "https://${local.do-grafana.hostnames[0]}/",
          },
          # https://grafana.com/docs/grafana/latest/auth/github/
          "auth.github" : {
            "enabled" : true,
            "allow_sign_up" : true,
            "client_id" : "3bcf3d74e9be175a63ab",
            # The grafana chart rejects secrets in plain text; read it from the env var set by envValueFrom.
            "client_secret" : "$__env{GRAFANA_GITHUB_OAUTH_CLIENT_SECRET}",
            "scopes" : "user:email,read:org",
            "auth_url" : "https://github.com/login/oauth/authorize",
            "token_url" : "https://github.com/login/oauth/access_token",
            "api_url" : "https://api.github.com/user",
            "allowed_organizations" : "HaxeFoundation",
            "team_ids" : data.github_team.system-admin.id,
          },
          "plugins" : {
            # Grafana preinstalls many datasource plugins, each running a backend process.
            # Only Prometheus, Loki, and Alertmanager are used here, so don't load the others.
            # Measured with Grafana 13.3.0: 15 -> 3 processes, 293Mi -> 219Mi.
            # Frontend-only apps (e.g. Logs/Metrics Drilldown) cost nothing and are kept.
            "disable_plugins" : join(",", [
              "cloudwatch",
              "elasticsearch",
              "grafana-postgresql-datasource",
              "grafana-pyroscope-datasource",
              "influxdb",
              "jaeger",
              "mssql",
              "mysql",
              "opentsdb",
              "stackdriver",
              "tempo",
              "zipkin",
              "grafana-advisor-app",
              "grafana-pyroscope-app",
              "grafana-exploretraces-app",
            ]),
          },
        },
        "defaultDashboardsTimezone" : "browser",
        "additionalDataSources" : local.do-kube-prometheus-stack.grafana-additional-datasources,
      }
    }),
  ]

  skip_crds = true

  timeout = 60 * 20 # 20 minutes

  depends_on = [
    module.do-kube-prometheus-stack-crds
  ]
}

resource "aws_route53_record" "do-grafana-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-grafana"
  type    = "CNAME"
  ttl     = "86400"
  records = ["do-k8s.haxe.org"]
}


resource "cloudflare_dns_record" "do-grafana-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "do-grafana"
  type    = "CNAME"
  ttl     = "86400"
  content = "do-k8s.haxe.org"
}
