locals {
  do_cluster_name = local.stack_name
}

data "digitalocean_kubernetes_versions" "k8s-1-21" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name         = local.do_cluster_name
  region       = "lon1"
  version      = data.digitalocean_kubernetes_versions.k8s-1-21.latest_version
  auto_upgrade = true

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    auto_scale = true
    min_nodes  = 2
    max_nodes  = 5
  }
}

provider "kubernetes" {
  alias = "do"
  host  = digitalocean_kubernetes_cluster.cluster.endpoint
  token = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  alias = "do"
  kubernetes {
    host  = digitalocean_kubernetes_cluster.cluster.endpoint
    token = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
    )
  }
}

resource "kubernetes_namespace" "do-monitoring" {
  provider = kubernetes.do
  metadata {
    name = "monitoring"
  }
}
