provider "grafana" {
  alias = "do"

  url  = "https://${local.do-grafana.hostnames[0]}"
  auth = "${local.do-grafana.user}:${local.do-grafana.password}"
}

module "do-grafana" {
  source = "./grafana"
  providers = {
    grafana = grafana.do
  }

  depends_on = [
    helm_release.do-ingress-nginx,
    helm_release.do-prometheus,
  ]
}
