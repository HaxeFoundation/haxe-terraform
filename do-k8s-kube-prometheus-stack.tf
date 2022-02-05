locals {
  do-prometheus = {
    hostnames = ["do-prom.haxe.org"]
  }
  do-grafana = {
    hostnames = ["do-grafana.haxe.org"]
    user     = "admin"
    password = random_password.grafana-admin-pw.result
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

resource "kubernetes_secret" "do-grafana-admin" {
  provider = kubernetes.do
  metadata {
    name      = "grafana-admin"
    namespace = kubernetes_namespace.do-monitoring.metadata[0].name
  }

  data = {
    admin-user     = local.do-grafana.user
    admin-password = local.do-grafana.password
  }
}

# kubectl -n monitoring create secret generic grafana-github-oauth-client-secret --from-literal=GRAFANA_GITHUB_OAUTH_CLIENT_SECRET=FIXME
data "kubernetes_secret" "do-grafana-github-oauth-client-secret" {
  provider = kubernetes.do
  metadata {
    name      = "grafana-github-oauth-client-secret"
    namespace = kubernetes_namespace.do-monitoring.metadata[0].name
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
  namespace  = kubernetes_namespace.do-monitoring.metadata[0].name
  version    = "30.2.0"
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
        "ingress" : {
          "enabled" : true,
          "hosts" : local.do-prometheus.hostnames,
          "pathType" : "Prefix",
          "annotations" : merge(
            local.do-oauth2-proxy.ingress_annotations,
            local.do-cert-manager.ingress_annotations,
          ),
          "tls" : [{
            "hosts" : local.do-prometheus.hostnames,
            "secretName" : "prometheus-tls"
          }]
        }
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
        "adminPassword" : random_password.grafana-admin-pw.result,
        "admin" : {
          "existingSecret" : kubernetes_secret.do-grafana-admin.metadata[0].name,
        },
        "env" : {
          "HOSTNAME" : local.do-grafana.hostnames[0],
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
            "client_secret" : data.kubernetes_secret.do-grafana-github-oauth-client-secret.data.GRAFANA_GITHUB_OAUTH_CLIENT_SECRET,
            "scopes" : "user:email,read:org",
            "auth_url" : "https://github.com/login/oauth/authorize",
            "token_url" : "https://github.com/login/oauth/access_token",
            "api_url" : "https://api.github.com/user",
            "allowed_organizations" : "HaxeFoundation",
            "team_ids" : data.github_team.system-admin.id,
          }
        },
      }
    }),
  ]

  skip_crds = true

  depends_on = [
    module.do-kube-prometheus-stack-crds
  ]
}

resource "aws_route53_record" "do-prom-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-prom"
  type    = "CNAME"
  ttl     = "86400"
  records = ["do-k8s.haxe.org"]
}

resource "aws_route53_record" "do-grafana-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-grafana"
  type    = "CNAME"
  ttl     = "86400"
  records = ["do-k8s.haxe.org"]
}
