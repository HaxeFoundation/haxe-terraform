locals {
  do_ingress_ip = data.kubernetes_service.do-ingress-nginx.status[0].load_balancer[0].ingress[0].ip
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
          # "use-proxy-protocol" : "true",
          "proxy-body-size" : "256m",
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
