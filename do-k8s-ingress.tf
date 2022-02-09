locals {
  # do-ingress-ip = data.kubernetes_service.do-ingress-nginx.status[0].load_balancer[0].ingress[0].ip
  # https://github.com/digitalocean/terraform-provider-digitalocean/issues/772
  do-ingress-ip = data.digitalocean_loadbalancer.do-ingress-nginx.ip
}

# https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
resource "helm_release" "do-ingress-nginx" {
  provider = helm.do

  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.13"

  values = [
    yamlencode({
      "controller" : {
        "replicaCount" : 2,
        "watchIngressWithoutClass" : true,
        "ingressClassResource" : {
          "enabled" : true,
          "default" : true,
        },
        "config" : {
          "use-forwarded-headers" : "true",
          "use-proxy-protocol" : "true",
          "proxy-body-size" : "256m",
          "http-snippet" : "proxy_cache_path /tmp/nginx_my_cache levels=1:2 keys_zone=mycache:2m use_temp_path=off max_size=2g inactive=48h;"
        },
        "metrics" : {
          "enabled" : true,
          "serviceMonitor" : {
            "enabled" : true,
            "scrapeInterval" : "15s",
          },
        },
        "service" : {
          "annotations" : {
            "service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol" : true,
            "service.beta.kubernetes.io/do-loadbalancer-hostname" : "do-k8s.haxe.org",
          }
        },
        "topologySpreadConstraints" : [
          {
            "maxSkew" : 1,
            "topologyKey" : "kubernetes.io/hostname",
            "whenUnsatisfiable" : "ScheduleAnyway",
            "labelSelector" : {
              "matchLabels" : {
                "app.kubernetes.io/instance" : "ingress-nginx"
              }
            }
          }
        ]
      },
    })
  ]
}

data "kubernetes_service" "do-ingress-nginx" {
  provider = kubernetes.do

  depends_on = [helm_release.do-ingress-nginx]
  metadata {
    name = "ingress-nginx-controller"
  }
}

data "digitalocean_loadbalancer" "do-ingress-nginx" {
  id = data.kubernetes_service.do-ingress-nginx.metadata[0].annotations["kubernetes.digitalocean.com/load-balancer-id"]
}

resource "aws_route53_record" "do-k8s-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "do-k8s"
  type    = "A"
  ttl     = "86400"
  records = [local.do-ingress-ip]
}
