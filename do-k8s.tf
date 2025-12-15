locals {
  do_cluster_name = local.stack_name
}

# List available Droplet sizes by `doctl compute size list`
resource "digitalocean_kubernetes_cluster" "cluster" {
  name         = local.do_cluster_name
  region       = "lon1"
  version      = "1.31.9-do.5"
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

resource "kubernetes_secret_v1" "do-k8s-imagepullsecrets" {
  provider = kubernetes.do
  metadata {
    name = "dockerhub-imagepullsecrets"
  }
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = "haxeci"
          password = data.aws_ssm_parameter.do-k8s-imagepullsecrets.value
          email    = "haxe-ci@onthewings.net"
          auth     = base64encode("haxeci:${data.aws_ssm_parameter.do-k8s-imagepullsecrets.value}")
        }
      }
    })
  }
  type = "kubernetes.io/dockerconfigjson"
}
