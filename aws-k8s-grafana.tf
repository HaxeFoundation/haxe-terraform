provider "grafana" {
  url  = "https://${local.aws-grafana.hostname}"
  auth = "${local.aws-grafana.user}:${local.aws-grafana.password}"
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
