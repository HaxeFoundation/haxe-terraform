# https://github.com/kubernetes/dashboard/tree/dfd20b42444fce5e8f739385e04c8c5b7adfcebf/charts/helm-chart/kubernetes-dashboard
resource "helm_release" "do-k8s-dashboard" {
  provider = helm.do

  name       = "k8s-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  # We can't upgrade to 7.0.0+ because there are breaking changes in the way authentication is handled.
  # https://github.com/kubernetes/dashboard/releases/tag/kubernetes-dashboard-7.0.0
  version = "6.0.8"

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
resource "kubernetes_cluster_role_binding_v1" "do-fullaccess" {
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
