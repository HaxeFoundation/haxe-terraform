locals {
  do-oauth2-proxy = {
    domains = {
      oauth2-proxy  = "do-oauth2-proxy.haxe.org"
      k8s-dashboard = "do-k8s.haxe.org"
    }
    container_port = 4180
    ingress_annotations = {
      "nginx.ingress.kubernetes.io/auth-url"    = "https://do-oauth2-proxy.haxe.org/oauth2/auth"
      "nginx.ingress.kubernetes.io/auth-signin" = "https://do-oauth2-proxy.haxe.org/oauth2/sign_in?rd=https://$host$request_uri"
    }
  }
}

resource "random_password" "cookie_secret" {
  length = 32
}

# kubectl create secret generic oauth2-proxy-client-secret --from-literal=OAUTH2_PROXY_CLIENT_SECRET=FIXME
data "kubernetes_secret_v1" "do-oauth2-proxy-client-secret" {
  provider = kubernetes.do
  metadata {
    name = "oauth2-proxy-client-secret"
  }
}

resource "kubernetes_deployment_v1" "do-oauth2-proxy" {
  provider = kubernetes.do
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
          image = "quay.io/oauth2-proxy/oauth2-proxy:v7.2.1"
          name  = "oauth2-proxy"

          port {
            container_port = local.do-oauth2-proxy.container_port
          }

          env {
            name  = "OAUTH2_PROXY_HTTP_ADDRESS"
            value = "0.0.0.0:${local.do-oauth2-proxy.container_port}"
          }
          env {
            name  = "OAUTH2_PROXY_WHITELIST_DOMAINS"
            value = "haxe.org,.haxe.org"
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
            value = "52d64c79e924c3c7ac3d"
          }
          env {
            name  = "OAUTH2_PROXY_CLIENT_SECRET"
            value = data.kubernetes_secret_v1.do-oauth2-proxy-client-secret.data.OAUTH2_PROXY_CLIENT_SECRET
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

resource "kubernetes_service_v1" "do-oauth2-proxy" {
  provider = kubernetes.do
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
      port     = local.do-oauth2-proxy.container_port
    }
  }
}

resource "kubernetes_ingress_v1" "do-oauth2-proxy" {
  for_each = local.do-oauth2-proxy.domains
  provider = kubernetes.do
  metadata {
    name = "oauth2-proxy-${each.key}"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"
    }
  }

  spec {
    ingress_class_name = "nginx"
    tls {
      hosts       = [each.value]
      secret_name = "oauth2-proxy-${each.key}-tls"
    }
    rule {
      host = each.value
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.do-oauth2-proxy.metadata[0].name
              port {
                number = local.do-oauth2-proxy.container_port
              }
            }
          }
          path = "/oauth2"
        }
      }
    }
  }
}

resource "aws_route53_record" "do-oauth2-proxy" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-oauth2-proxy"
  type    = "CNAME"
  ttl     = "86400"
  records = ["do-k8s.haxe.org"]
}
