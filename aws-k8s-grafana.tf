provider "grafana" {
  url  = "https://${local.grafana.hostname}"
  auth = "${local.grafana.user}:${local.grafana.password}"
}

module "grafana" {
  source = "./grafana"
  providers = {
    grafana = grafana
  }

  depends_on = [
    helm_release.ingress-nginx,
    helm_release.prometheus,
  ]
}
