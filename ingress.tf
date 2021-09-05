locals {
  ingress_hostname = data.kubernetes_service.ingress-nginx.status[0].load_balancer[0].ingress[0].hostname
}

# https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.1"

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
            "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" : "http",
            "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" : "https",
            "service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout" : 3600
          }
        }
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
