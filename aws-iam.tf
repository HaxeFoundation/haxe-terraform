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

resource "aws_iam_group" "k8s-admin" {
  name = "${local.stack_name}-k8s-admin"
}
resource "aws_iam_group_membership" "k8s-admin" {
  name  = "${local.stack_name}-admin-membership"
  group = aws_iam_group.k8s-admin.name
  users = [
    aws_iam_user.Andy.name,
    aws_iam_user.ibilon.name,
    aws_iam_user.waneck.name,
    aws_iam_user.TravisCI-Bot.name,
    aws_iam_user.haxelib-operator.name,
  ]
}

resource "aws_iam_user_policy_attachment" "TravisCI-Bot-readonly" {
  user       = aws_iam_user.TravisCI-Bot.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
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
