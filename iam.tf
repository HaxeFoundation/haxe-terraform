resource "aws_iam_user" "Andy" {
  name = "Andy"
}
resource "aws_iam_user" "ibilon" {
  name = "ibilon"
}
resource "aws_iam_user" "waneck" {
  name = "waneck"
}
resource "aws_iam_user" "serverless-admin" {
  name = "serverless-admin"
}
resource "aws_iam_user" "TravisCI-Bot" {
  name = "TravisCI-Bot"
}

resource "aws_iam_group" "admin" {
  name = "${local.stack_name}-admin"
}
resource "aws_iam_group_membership" "admin" {
  name  = "${local.stack_name}-admin-membership"
  group = aws_iam_group.admin.name
  users = [
    aws_iam_user.Andy.name,
    aws_iam_user.ibilon.name,
    aws_iam_user.waneck.name,
    aws_iam_user.serverless-admin.name,
    aws_iam_user.TravisCI-Bot.name,
  ]
}

resource "aws_iam_role" "k8s-admin" {
  name               = "${local.stack_name}-k8s-admin"
  assume_role_policy = data.aws_iam_policy_document.allow-self-assumerole.json
}
data "aws_iam_policy_document" "allow-self-assumerole" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_group_policy" "allow-assume-k8s-admin" {
  name   = "allow-assume-${local.stack_name}-k8s-admin"
  group  = aws_iam_group.admin.name
  policy = data.aws_iam_policy_document.allow-assume-k8s-admin.json
}
data "aws_iam_policy_document" "allow-assume-k8s-admin" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.k8s-admin.arn]
  }
}

resource "aws_iam_user_policy_attachment" "TravisCI-Bot-readonly" {
  user       = aws_iam_user.TravisCI-Bot.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "AmazonEKS_EBS_CSI_Driver_Policy" {
  name = "${local.stack_name}-AmazonEKS_EBS_CSI_Driver_Policy"

  # https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/v1.2.0/docs/example-iam-policy.json
  policy = file("${path.module}/AmazonEKS_EBS_CSI_Driver_Policy.json")
}

data "aws_arn" "oidc_provider" {
  arn = module.eks.oidc_provider_arn
}

data "aws_iam_policy_document" "assume-AmazonEKS_EBS_CSI_DriverRole" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${join("/", [for i, v in split("/", data.aws_arn.oidc_provider.resource) : v if i != 0])}:sub"
      values   = ["system:serviceaccount:kube-system:${local.ebs_controller_sa_name}"]
    }
  }
}

resource "aws_iam_role" "AmazonEKS_EBS_CSI_DriverRole" {
  name               = "${local.stack_name}-AmazonEKS_EBS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.assume-AmazonEKS_EBS_CSI_DriverRole.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_EBS_CSI_Driver_Policy" {
  role       = aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.name
  policy_arn = aws_iam_policy.AmazonEKS_EBS_CSI_Driver_Policy.arn
}
