locals {
  ingress_hostname = data.kubernetes_service.ingress-nginx.status[0].load_balancer[0].ingress[0].hostname
}

# https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
resource "helm_release" "ingress-nginx" {
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
        "service" : {
          "targetPorts" : {
            "http" : "http",
            "https" : "http",
          },
          "annotations" : {
            "service.beta.kubernetes.io/aws-load-balancer-ssl-cert" : aws_acm_certificate.haxe-org.arn,
            "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" : "tcp",
            "service.beta.kubernetes.io/aws-load-balancer-proxy-protocol" : "*",
            "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" : "https",
            "service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout" : 3600
          },
        },
        "config" : {
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

data "kubernetes_service" "ingress-nginx" {
  depends_on = [helm_release.ingress-nginx]
  metadata {
    name = "ingress-nginx-controller"
  }
}
