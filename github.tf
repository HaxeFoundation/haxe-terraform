data "github_team" "system-admin" {
  slug = "system-admin"
}

# haxe.org

resource "github_actions_variable" "haxe-org-AWS_DEFAULT_REGION" {
  repository    = "haxe.org"
  variable_name = "AWS_DEFAULT_REGION"
  value         = data.aws_region.current.name
}

resource "github_actions_variable" "haxe-org-AWS_ACCESS_KEY_ID" {
  repository    = "haxe.org"
  variable_name = "AWS_ACCESS_KEY_ID"
  value         = aws_iam_access_key.haxe-org-ci.id
}

resource "github_actions_variable" "haxe-org-S3_BUCKET" {
  repository    = "haxe.org"
  variable_name = "S3_BUCKET"
  value         = aws_s3_bucket.haxe-org.id
}

resource "github_actions_variable" "haxe-org-CLOUDFRONT_DISTRIBUTION_ID_STAGING" {
  repository    = "haxe.org"
  variable_name = "CLOUDFRONT_DISTRIBUTION_ID_STAGING"
  value         = aws_cloudfront_distribution.staging-haxe-org.id
}

resource "github_actions_variable" "haxe-org-CLOUDFRONT_DISTRIBUTION_ID_MASTER" {
  repository    = "haxe.org"
  variable_name = "CLOUDFRONT_DISTRIBUTION_ID_MASTER"
  value         = aws_cloudfront_distribution.haxe-org.id
}

resource "github_actions_secret" "haxe-org-AWS_SECRET_ACCESS_KEY" {
  repository      = "haxe.org"
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.haxe-org-ci.secret
}

# api.haxe.org

resource "github_actions_variable" "api-haxe-org-AWS_DEFAULT_REGION" {
  repository    = "api.haxe.org"
  variable_name = "AWS_DEFAULT_REGION"
  value         = data.aws_region.current.name
}

resource "github_actions_variable" "api-haxe-org-AWS_ACCESS_KEY_ID" {
  repository    = "api.haxe.org"
  variable_name = "AWS_ACCESS_KEY_ID"
  value         = aws_iam_access_key.api-haxe-org-ci.id
}

resource "github_actions_variable" "api-haxe-org-S3_BUCKET" {
  repository    = "api.haxe.org"
  variable_name = "S3_BUCKET"
  value         = module.s3_bucket_api-haxe-org.s3_bucket_id
}

resource "github_actions_variable" "api-haxe-org-CLOUDFRONT_DISTRIBUTION_ID" {
  repository    = "api.haxe.org"
  variable_name = "CLOUDFRONT_DISTRIBUTION_ID"
  value         = module.cloudfront_api-haxe-org.cloudfront_distribution_id
}

resource "github_actions_secret" "api-haxe-org-AWS_SECRET_ACCESS_KEY" {
  repository      = "api.haxe.org"
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.api-haxe-org-ci.secret
}
