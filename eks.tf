locals {
  cluster_name = local.stack_name

  # Let's use only one AZ, such that ebs can be reliably re-attached.
  eks_subnets = [module.vpc.public_subnets[0]]

  ebs_controller_sa_name = "ebs-csi-controller-sa"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws-iam-authenticator"
    args = [
      "token",
      "-i", module.eks.cluster_id,
      "-r", aws_iam_role.k8s-admin.arn, # comment this out when the eks module is not created yet
    ]
    env = {
      # AWS_ACCESS_KEY_ID
      # AWS_SECRET_ACCESS_KEY
      # AWS_DEFAULT_REGION
    }
  }

  experiments {
    manifest_resource = true
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws-iam-authenticator"
      args = [
        "token",
        "-i", module.eks.cluster_id,
        "-r", aws_iam_role.k8s-admin.arn, # comment this out when the eks module is not created yet
      ]
      env = {
        # AWS_ACCESS_KEY_ID
        # AWS_SECRET_ACCESS_KEY
        # AWS_DEFAULT_REGION
      }
    }
  }
}

# https://github.com/terraform-aws-modules/terraform-aws-eks
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.10.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.public_subnets
  enable_irsa     = true

  vpc_id = module.vpc.vpc_id

  worker_groups_launch_template = [{
    name = "${local.cluster_name}-spot"
    override_instance_types = [
      "t3.medium", "t3a.medium", "t4g.medium", "t2.medium",
    ]

    asg_min_size                             = 2
    asg_max_size                             = 4
    on_demand_base_capacity                  = 0
    on_demand_percentage_above_base_capacity = 0
    spot_allocation_strategy                 = "lowest-price"

    public_ip          = true
    ami_id             = "ami-044dfe22e0788d8ed" # avoid auto update
    root_volume_type   = "gp2"
    subnets            = local.eks_subnets,
    kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
  }]

  worker_additional_security_group_ids = [
    # aws_security_group.all_worker_mgmt.id,
  ]

  map_roles = [
    {
      rolearn  = aws_iam_role.k8s-admin.arn
      username = aws_iam_role.k8s-admin.name
      groups   = ["system:masters"]
    }
  ]

  kubeconfig_aws_authenticator_additional_args = [
    "-r", aws_iam_role.k8s-admin.arn
  ]

  depends_on = [
    module.vpc, # EKS needs a VPC with an Internet gateway, so the VPC module better be completely created
  ]
}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

# https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/charts/aws-ebs-csi-driver
resource "helm_release" "aws-ebs-csi-driver" {
  namespace  = "kube-system"
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver/"
  chart      = "aws-ebs-csi-driver"
  version    = "2.0.4"

  values = [yamlencode(
    {
      "controller" : {
        "serviceAccount" : {
          "create" : true,
          "name" : local.ebs_controller_sa_name,
          "annotations" : {
            "eks.amazonaws.com/role-arn" : aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.arn
          }
        }
      }
    }
  )]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
