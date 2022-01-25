locals {
  loki = {
    hostname     = "loki.haxe.org"
    user         = "loki"
    password     = random_pet.loki-pw.keepers.loki-pw
    index_prefix = "loki_"
  }
}

output "loki" {
  value     = local.loki
  sensitive = true
}

resource "aws_iam_user" "loki" {
  name = "loki"
}
resource "aws_iam_access_key" "loki" {
  user = aws_iam_user.loki.name
}
resource "aws_iam_user_policy" "loki" {
  user   = aws_iam_user.loki.name
  policy = data.aws_iam_policy_document.loki.json
}

# https://grafana.com/docs/loki/latest/operations/storage/#cloud-storage-permissions
data "aws_iam_policy_document" "loki" {
  statement {
    sid = "s3"

    actions = [
      "s3:ListObjects",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      module.loki_s3_bucket.s3_bucket_arn,
      "${module.loki_s3_bucket.s3_bucket_arn}/*",
    ]
  }
}

module "loki_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.9.0"

  bucket_prefix = "loki"
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

resource "kubernetes_secret" "loki-basic-auth" {
  metadata {
    namespace = kubernetes_namespace.monitoring.metadata[0].name
    name      = "loki-basic-auth-${random_pet.loki-pw.id}" # forces replacement
  }

  data = {
    (local.loki.user) = bcrypt(random_pet.loki-pw.keepers.loki-pw)
  }

  lifecycle {
    # bcrypt is not a pure function...
    # The random_pet will take care of recreating this secret when loki-pw changes.
    ignore_changes = [
      data
    ]
  }
}

# https://github.com/grafana/helm-charts/tree/main/charts/loki-stack
resource "helm_release" "loki-stack" {
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  version    = "2.5.0"
  values = [
    yamlencode({
      "loki" : {
        "enabled" : true,
        "ingress" : {
          "enabled" : true,
          "hosts" : [
            {
              "host" : local.loki.hostname,
              "paths" : ["/"],
            },
          ],
          "annotations" : {
            "nginx.ingress.kubernetes.io/auth-type" : "basic",
            "nginx.ingress.kubernetes.io/auth-secret" : kubernetes_secret.loki-basic-auth.metadata[0].name,
            "nginx.ingress.kubernetes.io/auth-secret-type" : "auth-map",
            "nginx.ingress.kubernetes.io/auth-realm" : "Authentication Required",
          }
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
                "object_store" : "s3"
                "schema" : "v11"
                "index" : {
                  "prefix" : local.loki.index_prefix
                  "period" : "24h"
                }
              }
            ]
          }
          "storage_config" : {
            "aws" : {
              "s3" : "s3://${aws_iam_access_key.loki.id}:${urlencode(aws_iam_access_key.loki.secret)}@${data.aws_region.current.name}/${module.loki_s3_bucket.s3_bucket_id}"
              "s3forcepathstyle" : true
            }
            "boltdb_shipper" : {
              "shared_store" : "s3"
            }
          }
          "compactor" : {
            "shared_store" : "s3"
          }
        }
      },
      "promtail" : {
        "enabled" : true,
      }
    })
  ]
}

resource "aws_route53_record" "aws-loki-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "aws-loki"
  type    = "CNAME"
  ttl     = "86400"
  records = ["aws-k8s.haxe.org"]
}
