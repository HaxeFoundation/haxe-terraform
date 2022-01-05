resource "aws_iam_user" "haxelib-operator" {
  name = "haxelib-operator"
}

resource "aws_iam_role" "haxelib-operator" {
  name               = "${local.stack_name}-haxelib-operator"
  assume_role_policy = data.aws_iam_policy_document.allow-self-assumerole.json
}

resource "aws_iam_group_policy" "allow-assume-haxelib-operator" {
  name   = "allow-assume-${local.stack_name}-haxelib-operator"
  group  = aws_iam_group.k8s-admin.name
  policy = data.aws_iam_policy_document.allow-assume-haxelib-operator.json
}
data "aws_iam_policy_document" "allow-assume-haxelib-operator" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.haxelib-operator.arn]
  }
}

resource "aws_iam_group_policy" "haxelib-terraform" {
  name   = "${local.stack_name}-haxelib-terraform"
  group  = aws_iam_group.k8s-admin.name
  policy = data.aws_iam_policy_document.haxelib-terraform.json
}
data "aws_iam_policy_document" "haxelib-terraform" {
  # https://www.terraform.io/docs/language/settings/backends/s3.html
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [module.s3_bucket_terraform.s3_bucket_arn]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["${module.s3_bucket_terraform.s3_bucket_arn}/haxelib.tfstate"]
  }
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.haxe-terraform.arn]
  }
}

resource "aws_iam_role_policy" "haxelib-operator" {
  name   = "${local.stack_name}-haxelib-operator"
  role   = aws_iam_role.haxelib-operator.id
  policy = data.aws_iam_policy_document.haxelib-operator.json
}
data "aws_iam_policy_document" "haxelib-operator" {
  # lib.haxe.org S3 bucket
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:aws:s3:::lib.haxe.org/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::lib.haxe.org"]
  }

  # RDS
  statement {
    effect    = "Allow"
    actions   = ["rds:*"]
    resources = ["*"]
  }

  # Route 53
  statement {
    effect    = "Allow"
    actions   = ["route53:*"]
    resources = [aws_route53_zone.haxe-org.arn]
  }
  statement {
    effect    = "Allow"
    actions   = ["route53:GetChange"]
    resources = ["*"]
  }

  # for aws_canonical_user_id data source
  statement {
    effect    = "Allow"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}
resource "aws_iam_role_policy_attachment" "name" {
  role       = aws_iam_role.haxelib-operator.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk"
}

resource "aws_iam_access_key" "haxelib-operator" {
  user = aws_iam_user.haxelib-operator.name
}

resource "github_actions_secret" "haxelib-AWS_ACCESS_KEY_ID" {
  repository      = "haxelib"
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.haxelib-operator.id
}

resource "github_actions_secret" "haxelib-AWS_SECRET_ACCESS_KEY" {
  repository      = "haxelib"
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.haxelib-operator.secret
}


resource "aws_iam_user" "haxelib-server" {
  name = "haxelib-server"
}

resource "aws_iam_access_key" "haxelib-server" {
  user = aws_iam_user.haxelib-server.name
}

resource "kubernetes_secret" "haxelib-server" {
  metadata {
    name = "haxelib-server"
  }
  data = {
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.haxelib-server.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.haxelib-server.secret
    AWS_DEFAULT_REGION    = data.aws_region.current.name
  }
}

resource "aws_iam_user_policy" "haxelib-server" {
  name   = "${local.stack_name}-haxelib-server"
  user   = aws_iam_user.haxelib-server.name
  policy = data.aws_iam_policy_document.haxelib-server.json
}
data "aws_iam_policy_document" "haxelib-server" {
  # lib.haxe.org S3 bucket
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:aws:s3:::lib.haxe.org/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::lib.haxe.org"]
  }
}
