locals {
  oauth2-proxy = {
    domains = {
      oauth2-proxy  = "oauth2-proxy.haxe.org"
      k8s-dashboard = "k8s.haxe.org"
    }
    container_port = 4180
    ingress_annotations = {
      "nginx.ingress.kubernetes.io/auth-url"    = "https://oauth2-proxy.haxe.org/oauth2/auth"
      "nginx.ingress.kubernetes.io/auth-signin" = "https://oauth2-proxy.haxe.org/oauth2/sign_in?rd=https://$host$request_uri"
    }
  }
}

resource "random_password" "cookie_secret" {
  length = 32
}

data "aws_ssm_parameter" "OAUTH2_PROXY_CLIENT_SECRET" {
  name = "OAUTH2_PROXY_CLIENT_SECRET"
}

resource "kubernetes_deployment" "oauth2-proxy" {
  metadata {
    name = "oauth2-proxy"
    labels = {
      "app.kubernetes.io/name" = "oauth2-proxy"
    }
  }

  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "oauth2-proxy"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "oauth2-proxy"
        }
      }

      spec {
        container {
          image = "quay.io/oauth2-proxy/oauth2-proxy:v7.1.3"
          name  = "oauth2-proxy"

          port {
            container_port = local.oauth2-proxy.container_port
          }

          env {
            name  = "OAUTH2_PROXY_HTTP_ADDRESS"
            value = "0.0.0.0:${local.oauth2-proxy.container_port}"
          }
          env {
            name  = "OAUTH2_PROXY_WHITELIST_DOMAINS"
            value = join(",", values(local.oauth2-proxy.domains))
          }
          env {
            name  = "OAUTH2_PROXY_COOKIE_DOMAINS"
            value = ".haxe.org"
          }
          env {
            name  = "OAUTH2_PROXY_COOKIE_SECRET"
            value = random_password.cookie_secret.result
          }
          env {
            name  = "OAUTH2_PROXY_CUSTOM_SIGN_IN_LOGO"
            value = "-"
          }
          env {
            name  = "OAUTH2_PROXY_EMAIL_DOMAINS"
            value = "*"
          }
          env {
            name  = "OAUTH2_PROXY_PROVIDER"
            value = "github"
          }
          env {
            name  = "OAUTH2_PROXY_CLIENT_ID"
            value = "d509e726c4664c0c7bfa"
          }
          env {
            name  = "OAUTH2_PROXY_CLIENT_SECRET"
            value = data.aws_ssm_parameter.OAUTH2_PROXY_CLIENT_SECRET.value
          }
          env {
            name  = "OAUTH2_PROXY_GITHUB_ORG"
            value = "HaxeFoundation"
          }
          env {
            name  = "OAUTH2_PROXY_GITHUB_TEAM"
            value = "system-admin"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "oauth2-proxy" {
  metadata {
    name = "oauth2-proxy"
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "oauth2-proxy"
    }

    port {
      name     = "http"
      protocol = "TCP"
      port     = local.oauth2-proxy.container_port
    }
  }
}

resource "kubernetes_ingress" "oauth2-proxy" {
  for_each = local.oauth2-proxy.domains

  metadata {
    name = "oauth2-proxy-${each.key}"
  }

  spec {
    rule {
      host = each.value
      http {
        path {
          backend {
            service_name = kubernetes_service.oauth2-proxy.metadata[0].name
            service_port = local.oauth2-proxy.container_port
          }
          path = "/oauth2"
        }
      }
    }
  }
}

resource "aws_route53_record" "oauth2-proxy" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "oauth2-proxy"
  type    = "CNAME"
  ttl     = "30"
  records = [local.ingress_hostname]
}
