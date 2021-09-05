locals {
  loki = {
    hostname = "loki.haxe.org"
    user     = "loki"
    password = random_pet.loki-pw.keepers.loki-pw
  }
}

output "loki" {
  value     = local.loki
  sensitive = true
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
  version    = "2.4.1"
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
          "enabled" : true,
          "size" : "10Gi",
        }
      },
      "promtail" : {
        "enabled" : true,
      }
    })
  ]
}

resource "aws_route53_record" "loki-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "loki"
  type    = "CNAME"
  ttl     = "30"
  records = [local.ingress_hostname]
}
