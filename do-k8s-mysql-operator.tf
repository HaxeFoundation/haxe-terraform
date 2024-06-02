module "do-mysql-operator-crds" {
  source = "./mysql-operator.crds"
  providers = {
    kubernetes = kubernetes.do
  }
}

resource "helm_release" "do-mysql-operator" {
  provider = helm.do

  name      = "mysql-operator"
  namespace = kubernetes_namespace_v1.do-mysql-operator.metadata[0].name
  chart     = "./mysql-operator/helm/mysql-operator"
  values = [
    yamlencode({}),
  ]

  skip_crds = true

  depends_on = [
    module.do-mysql-operator-crds
  ]
}
