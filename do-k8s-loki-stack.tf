locals {
  do-loki = {
    hostname     = "do-loki.haxe.org"
    user         = "loki"
    password     = random_pet.loki-pw.keepers.loki-pw
    index_prefix = "loki_"
  }
}

resource "random_string" "do-loki-bucket-suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "digitalocean_spaces_bucket" "loki" {
  name          = "loki-${random_string.do-loki-bucket-suffix.result}"
  region        = "fra1"
  acl           = "private"
  force_destroy = true
}

resource "random_password" "loki-pw" {
  length  = 32
  special = false
}

resource "random_pet" "loki-pw" {
  keepers = {
    loki-pw = random_password.loki-pw.result
  }
}

# kubectl -n monitoring create secret generic loki-do-spaces --from-literal=SPACES_KEY=FIXME --from-literal=SPACES_SECRET=FIXME
data "kubernetes_secret" "loki-do-spaces" {
  provider = kubernetes.do
  metadata {
    namespace = kubernetes_namespace.do-monitoring.metadata[0].name
    name      = "loki-do-spaces"
  }
}

resource "kubernetes_secret" "do-loki-basic-auth" {
  provider = kubernetes.do
  metadata {
    namespace = kubernetes_namespace.do-monitoring.metadata[0].name
    name      = "loki-basic-auth-${random_pet.loki-pw.id}" # forces replacement
  }

  data = {
    (local.do-loki.user) = random_password.loki-pw.bcrypt_hash
  }
}

# https://github.com/grafana/helm-charts/tree/main/charts/loki-stack
resource "helm_release" "do-loki-stack" {
  provider = helm.do

  namespace  = kubernetes_namespace.do-monitoring.metadata[0].name
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.6.3"
  values = [
    yamlencode({
      "loki" : {
        "enabled" : true,
        "ingress" : {
          "enabled" : true,
          "hosts" : [
            {
              "host" : local.do-loki.hostname,
              "paths" : ["/"],
            },
          ],
          "annotations" : merge(
            {
              "nginx.ingress.kubernetes.io/auth-type" : "basic",
              "nginx.ingress.kubernetes.io/auth-secret" : kubernetes_secret.do-loki-basic-auth.metadata[0].name,
              "nginx.ingress.kubernetes.io/auth-secret-type" : "auth-map",
              "nginx.ingress.kubernetes.io/auth-realm" : "Authentication Required",
            },
            local.do-cert-manager.ingress_annotations,
          ),
          "tls" : [{
            "hosts" : [local.do-loki.hostname],
            "secretName" : "loki-tls"
          }]
        },
        "persistence" : {
          "enabled" : false,
        }
        "config" : {
          "schema_config" : {
            "configs" : [
              {
                "from" : "2021-01-01"
                "store" : "boltdb-shipper"
                "object_store" : "aws"
                "schema" : "v11"
                "index" : {
                  "prefix" : local.do-loki.index_prefix
                  "period" : "24h"
                }
              }
            ]
          }
          "storage_config" : {
            "aws" : {
              # "s3" : "https://${data.kubernetes_secret.loki-do-spaces.data.SPACES_KEY}:${urlencode(data.kubernetes_secret.loki-do-spaces.data.SPACES_SECRET)}@${digitalocean_spaces_bucket.loki.region}.digitaloceanspaces.com/${digitalocean_spaces_bucket.loki.name}"
              # "s3" : "https://${data.kubernetes_secret.loki-do-spaces.data.SPACES_KEY}:${urlencode(data.kubernetes_secret.loki-do-spaces.data.SPACES_SECRET)}@${digitalocean_spaces_bucket.loki.bucket_domain_name}"
              "bucketnames" : digitalocean_spaces_bucket.loki.name,
              "endpoint" : "${digitalocean_spaces_bucket.loki.region}.digitaloceanspaces.com",
              "region" : digitalocean_spaces_bucket.loki.region,
              "access_key_id" : data.kubernetes_secret.loki-do-spaces.data.SPACES_KEY,
              "secret_access_key" : data.kubernetes_secret.loki-do-spaces.data.SPACES_SECRET,
              "s3forcepathstyle" : true,
            }
            "boltdb_shipper" : {
              "shared_store" : "s3"
            }
          }
          "compactor" : {
            "shared_store" : "s3",
            "retention_enabled" : true,
          }
          "limits_config" : {
            "retention_period" : "1440h" # 60 days
          }
        }
      },
      "promtail" : {
        "enabled" : true,
      }
    })
  ]
}

resource "aws_route53_record" "do-loki-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-loki"
  type    = "CNAME"
  ttl     = "86400"
  records = ["do-k8s.haxe.org"]
}
