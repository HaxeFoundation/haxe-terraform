locals {
  prometheus = {
    hostname = "prom.haxe.org"
  }
  grafana = {
    hostname = "grafana.haxe.org"
    user     = "admin"
    password = random_password.grafana-admin-pw.result
  }
}

output "grafana" {
  value     = local.grafana
  sensitive = true
}

resource "random_password" "grafana-admin-pw" {
  length  = 32
  special = false
}

resource "kubernetes_secret" "grafana-admin" {
  metadata {
    name      = "grafana-admin"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }

  data = {
    admin-user     = local.grafana.user
    admin-password = local.grafana.password
  }
}

data "aws_ssm_parameter" "GRAFANA_GITHUB_OAUTH_CLIENT_SECRET" {
  name = "GRAFANA_GITHUB_OAUTH_CLIENT_SECRET"
}

# earthly +kube-prometheus-stack.crds
module "kube-prometheus-stack-crds" {
  source = "./kube-prometheus-stack.crds"
}

resource "helm_release" "prometheus" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "23.3.2"
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
        "ingress" : {
          "enabled" : true,
          "hosts" : [local.prometheus.hostname],
          "pathType" : "Prefix",
          "annotations" : local.oauth2-proxy.ingress_annotations,
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
                "storageClassName" : "gp2",
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
          "hosts" : [local.grafana.hostname]
          "pathType" : "Prefix",
        },
        "persistence" : {
          "enabled" : true,
          "size" : "10Gi",
        },
        "adminPassword" : random_password.grafana-admin-pw.result,
        "admin" : {
          "existingSecret" : kubernetes_secret.grafana-admin.metadata[0].name,
        },
        "env" : {
          "HOSTNAME" : local.grafana.hostname,
        },
        "grafana.ini" : {
          "server" : {
            # https://grafana.com/docs/grafana/latest/administration/configuration/#root_url
            "root_url" : "https://${local.grafana.hostname}/",
          },
          # https://grafana.com/docs/grafana/latest/auth/github/
          "auth.github" : {
            "enabled" : true,
            "allow_sign_up" : true,
            "client_id" : "eb0775533ce2551dd1de",
            "client_secret" : data.aws_ssm_parameter.GRAFANA_GITHUB_OAUTH_CLIENT_SECRET.value,
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
    module.kube-prometheus-stack-crds
  ]
}

resource "aws_route53_record" "prom-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "prom"
  type    = "CNAME"
  ttl     = "86400"
  records = [local.ingress_hostname]
}

resource "aws_route53_record" "grafana-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "grafana"
  type    = "CNAME"
  ttl     = "86400"
  records = [local.ingress_hostname]
}
