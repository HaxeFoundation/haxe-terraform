locals {
  build_haxe_org = {
    stage = {
      dev = {
        replicas  = 1
        subdomain = "development-build"
        host      = "development-build.haxe.org"
        image     = "ghcr.io/haxefoundation/build.haxe.org:0d63f08abcffad3bb7fa92e7252cc8ab4f340032"
        proxied   = false
      }
      prod = {
        replicas  = 2
        subdomain = "build"
        host      = "build.haxe.org"
        image     = "ghcr.io/haxefoundation/build.haxe.org:0d63f08abcffad3bb7fa92e7252cc8ab4f340032"
        proxied   = true
      }
    }
  }
}

# The ones with "AWS_" are for the previous S3 bucket from Cauê Waneck
data "aws_ssm_parameter" "HXBUILDS_AWS_ACCESS_KEY_ID" {
  name = "HXBUILDS_AWS_ACCESS_KEY_ID"
}
data "aws_ssm_parameter" "HXBUILDS_AWS_SECRET_ACCESS_KEY" {
  name = "HXBUILDS_AWS_SECRET_ACCESS_KEY"
}

data "aws_ssm_parameter" "HXBUILDS_ACCESS_KEY_ID" {
  name = "HXBUILDS_ACCESS_KEY_ID"
}
data "aws_ssm_parameter" "HXBUILDS_SECRET_ACCESS_KEY" {
  name = "HXBUILDS_SECRET_ACCESS_KEY"
}

data "aws_ssm_parameter" "hxbuilds_sippy_r2_access_key_id" {
  name = "hxbuilds_sippy_r2_access_key_id"
}
data "aws_ssm_parameter" "hxbuilds_sippy_r2_secret_access_key" {
  name = "hxbuilds_sippy_r2_secret_access_key"
}

data "aws_ssm_parameter" "hxbuilds_github_actions_r2_access_key_id" {
  name = "hxbuilds_github_actions_r2_access_key_id"
}
data "aws_ssm_parameter" "hxbuilds_github_actions_r2_secret_access_key" {
  name = "hxbuilds_github_actions_r2_secret_access_key"
}


resource "kubernetes_secret_v1" "do-hxbuilds" {
  provider = kubernetes.do
  metadata {
    name = "hxbuilds"
  }
  data = {
    HXBUILDS_ACCESS_KEY_ID     = data.aws_ssm_parameter.HXBUILDS_ACCESS_KEY_ID.value
    HXBUILDS_SECRET_ACCESS_KEY = data.aws_ssm_parameter.HXBUILDS_SECRET_ACCESS_KEY.value
  }
}

resource "kubernetes_deployment_v1" "do-build-haxe-org" {
  for_each = local.build_haxe_org.stage

  provider = kubernetes.do
  metadata {
    name = "build-haxe-org-${each.key}"
    labels = {
      "app.kubernetes.io/name"     = "build-haxe-org"
      "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
    }
  }

  spec {
    replicas = each.value.replicas

    selector {
      match_labels = {
        "app.kubernetes.io/name"     = "build-haxe-org"
        "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name"     = "build-haxe-org"
          "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
        }
      }

      spec {
        topology_spread_constraint {
          max_skew           = 1
          topology_key       = "kubernetes.io/hostname"
          when_unsatisfiable = "ScheduleAnyway"
          label_selector {
            match_labels = {
              "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
            }
          }
        }

        container {
          image = each.value.image
          name  = "build-haxe-org"

          port {
            container_port = 3000
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "200Mi"
            }
            limits = {
              memory = "500Mi"
            }
          }

          env {
            name = "HXBUILDS_ACCESS_KEY_ID"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.do-hxbuilds.metadata[0].name
                key  = "HXBUILDS_ACCESS_KEY_ID"
              }
            }
          }
          env {
            name = "HXBUILDS_SECRET_ACCESS_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.do-hxbuilds.metadata[0].name
                key  = "HXBUILDS_SECRET_ACCESS_KEY"
              }
            }
          }

          env {
            name  = "HXBUILDS_ENDPOINT"
            value = "https://${local.cloudflare.account_id}.r2.cloudflarestorage.com"
          }

          env {
            name  = "HXBUILDS_FORCE_PATH_STYLE"
            value = "true"
          }

          env {
            name  = "HXBUILDS_BUCKET"
            value = cloudflare_r2_bucket.hxbuilds.name
          }

          # Previous code use "AWS_" prefix.
          # Should remove it once both dev and prod are updated.
          env {
            name = "HXBUILDS_AWS_ACCESS_KEY_ID"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.do-hxbuilds.metadata[0].name
                key  = "HXBUILDS_ACCESS_KEY_ID"
              }
            }
          }
          env {
            name = "HXBUILDS_AWS_SECRET_ACCESS_KEY"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.do-hxbuilds.metadata[0].name
                key  = "HXBUILDS_SECRET_ACCESS_KEY"
              }
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 15
            timeout_seconds       = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_pod_disruption_budget_v1" "do-build-haxe-org" {
  for_each = { for k, v in local.build_haxe_org.stage : k => v if v.replicas > 1 }

  provider = kubernetes.do
  metadata {
    name = "build-haxe-org-${each.key}"
  }
  spec {
    min_available = 1
    selector {
      match_labels = {
        "app.kubernetes.io/name"     = "build-haxe-org"
        "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
      }
    }
  }
}

resource "kubernetes_service_v1" "do-build-haxe-org" {
  for_each = local.build_haxe_org.stage

  provider = kubernetes.do
  metadata {
    name = "build-haxe-org-${each.key}"
  }

  spec {
    selector = {
      "app.kubernetes.io/name"     = "build-haxe-org"
      "app.kubernetes.io/instance" = "build-haxe-org-${each.key}"
    }

    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = 3000
    }
  }
}

resource "kubernetes_ingress_v1" "do-build-haxe-org" {
  for_each = local.build_haxe_org.stage

  provider = kubernetes.do
  metadata {
    name = "build-haxe-org-${each.key}"
    annotations = {
      "cert-manager.io/cluster-issuer" = "letsencrypt-production"

      # https://nginx.org/en/docs/http/ngx_http_proxy_module.html
      "nginx.ingress.kubernetes.io/proxy-buffering"       = "on"
      "nginx.ingress.kubernetes.io/configuration-snippet" = <<-EOT
        proxy_set_header Cookie "";
        proxy_cache mycache;
        proxy_cache_key "$scheme$request_method$host$request_uri";
        proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
        proxy_cache_background_update on;
        proxy_cache_revalidate on;
        proxy_cache_lock on;
        add_header X-Cache-Status $upstream_cache_status;
      EOT
    }
  }

  spec {
    ingress_class_name = "nginx"
    tls {
      hosts       = [each.value.host]
      secret_name = "build-haxe-org-${each.key}-tls"
    }
    rule {
      host = each.value.host
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.do-build-haxe-org[each.key].metadata[0].name
              port {
                number = 80
              }
            }
          }
          path      = "/"
          path_type = "Prefix"
        }
      }
    }
  }
}

resource "cloudflare_dns_record" "do-build-haxe-org" {
  for_each = local.build_haxe_org.stage

  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = each.value.subdomain
  type    = "CNAME"
  ttl     = 1
  content = "do-k8s.haxe.org"
  proxied = each.value.proxied
}

resource "cloudflare_r2_bucket" "hxbuilds" {
  account_id = local.cloudflare.account_id
  name       = "hxbuilds-hjtpx7fj"
  location   = "weur"
}

resource "cloudflare_r2_bucket_sippy" "hxbuilds" {
  account_id  = local.cloudflare.account_id
  bucket_name = cloudflare_r2_bucket.hxbuilds.name
  destination = {
    cloud_provider    = "r2"
    access_key_id     = data.aws_ssm_parameter.hxbuilds_sippy_r2_access_key_id.value
    secret_access_key = data.aws_ssm_parameter.hxbuilds_sippy_r2_secret_access_key.value
  }
  source = {
    bucket            = "hxbuilds"
    cloud_provider    = "aws"
    access_key_id     = data.aws_ssm_parameter.HXBUILDS_AWS_ACCESS_KEY_ID.value
    secret_access_key = data.aws_ssm_parameter.HXBUILDS_AWS_SECRET_ACCESS_KEY.value
    region            = "us-east-1"
  }
}

resource "cloudflare_r2_custom_domain" "hxbuilds" {
  account_id  = local.cloudflare.account_id
  bucket_name = cloudflare_r2_bucket.hxbuilds.name
  domain      = "${cloudflare_r2_bucket.hxbuilds.name}.haxe.org"
  enabled     = true
  zone_id     = local.cloudflare.zones.haxe-org.zone_id
}

resource "github_actions_variable" "hxbuilds_github_actions_r2_access_key_id" {
  repository    = "haxe"
  variable_name = "R2_ACCESS_KEY_ID"
  value         = data.aws_ssm_parameter.hxbuilds_github_actions_r2_access_key_id.value
}

resource "github_actions_secret" "hxbuilds_github_actions_r2_secret_access_key" {
  repository      = "haxe"
  secret_name     = "R2_SECRET_ACCESS_KEY"
  plaintext_value = data.aws_ssm_parameter.hxbuilds_github_actions_r2_secret_access_key.value
}

resource "github_actions_variable" "hxbuilds_github_actions_r2_endpoint" {
  repository    = "haxe"
  variable_name = "R2_ENDPOINT"
  value         = "https://${local.cloudflare.account_id}.r2.cloudflarestorage.com"
}
