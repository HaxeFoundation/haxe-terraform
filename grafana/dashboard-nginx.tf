resource "grafana_dashboard" "nginx" {
  # Source: https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/grafana/dashboards/nginx.json
  config_json = file("${path.module}/dashboard-nginx.json")
  overwrite   = true
}
