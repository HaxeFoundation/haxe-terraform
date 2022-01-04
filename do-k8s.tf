locals {
  do_cluster_name = local.stack_name
}

data "digitalocean_kubernetes_versions" "k8s-1-21" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = local.do_cluster_name
  region = "lon1"
  version = data.digitalocean_kubernetes_versions.k8s-1-21.latest_version
  auto_upgrade = true

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    auto_scale = true
    min_nodes  = 2
    max_nodes  = 5
  }
}
