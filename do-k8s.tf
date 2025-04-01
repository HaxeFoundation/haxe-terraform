locals {
  do_cluster_name = local.stack_name
}

# List available Droplet sizes by `doctl compute size list`
resource "digitalocean_kubernetes_cluster" "cluster" {
  name         = local.do_cluster_name
  region       = "lon1"
  version      = "1.29.13-do.0"
  auto_upgrade = true

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    auto_scale = true
    min_nodes  = 3
    max_nodes  = 4
  }

  lifecycle {
    prevent_destroy = true
  }
}

# resource "digitalocean_kubernetes_node_pool" "s-4vcpu-8gb" {
#   cluster_id = digitalocean_kubernetes_cluster.cluster.id
#   name       = "s-4vcpu-8gb"
#   size       = "s-4vcpu-8gb"
#   node_count = 1
# }

provider "kubernetes" {
  alias = "do"

  # run `earthly +do-kubeconfig` to generate this file
  config_path = "./kubeconfig_do"
}

provider "helm" {
  alias = "do"
  kubernetes {
    config_path = "./kubeconfig_do"
  }
}

resource "kubernetes_namespace_v1" "do-monitoring" {
  provider = kubernetes.do
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace_v1" "do-mysql-operator" {
  provider = kubernetes.do
  metadata {
    name = "mysql-operator"
  }
}
