# https://github.com/kubernetes/dashboard/tree/master/aio/deploy/helm-chart/kubernetes-dashboard
resource "helm_release" "do-k8s-dashboard" {
  provider = helm.do

  name       = "k8s-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "5.0.5"

  values = [yamlencode({
    "protocolHttp" : true,
    "service" : {
      "externalPort" : 80
    },
    "ingress" : {
      "enabled" : true,
      "hosts" : ["do-k8s.haxe.org"],
      "annotations" : merge(
        local.do-oauth2-proxy.ingress_annotations,
        {
          "cert-manager.io/cluster-issuer" : "letsencrypt-production"
        },
      ),
      "tls" : [{
        "hosts" : ["do-k8s.haxe.org"],
        "secretName" : "k8s-dashboard-tls",
      }],
    },
    "extraArgs" : ["--enable-skip-login"], // the whole dashboard is guarded by oauth2-proxy
  })]
}

# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/README.md#admin-privileges
resource "kubernetes_cluster_role_binding" "do-fullaccess" {
  provider = kubernetes.do
  metadata {
    name = "k8s-dashboard"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind = "ServiceAccount"
    name = "k8s-dashboard-kubernetes-dashboard"
  }
}
