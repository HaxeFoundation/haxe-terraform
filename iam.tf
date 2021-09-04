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
