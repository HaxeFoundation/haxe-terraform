module "s3_bucket_terraform" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.10.1"

  bucket = "haxe-terraform"
  acl    = "private"

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      id      = "noncurrent"
      enabled = true
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "GLACIER"
        },
      ]
      noncurrent_version_expiration = {
        days = 300
      }
    }
  ]
}

resource "aws_s3_bucket" "api-haxe-org" {
  bucket = "api.haxe.org"
}

resource "aws_s3_bucket" "aws-sdk-neko" {
  bucket = "aws-sdk-neko"
}

resource "aws_s3_bucket" "blog-haxe-org" {
  bucket = "blog.haxe.org"
}

resource "aws_s3_bucket" "build-haxe-org" {
  bucket = "build.haxe.org"
}

resource "aws_s3_bucket" "code-haxe-org" {
  bucket = "code.haxe.org"
}

resource "aws_s3_bucket" "haxe-blog" {
  bucket = "haxe-blog"
}

resource "aws_s3_bucket" "haxe-org" {
  bucket = "haxe.org"
}

resource "aws_s3_bucket" "nekovm-org" {
  bucket = "nekovm.org"
}

resource "aws_s3_bucket" "staging-haxe-org" {
  bucket = "staging.haxe.org"
}

resource "aws_s3_bucket" "www-haxe-org" {
  bucket = "www.haxe.org"
}

resource "aws_s3_bucket" "www-haxedevelop-org" {
  bucket = "www.haxedevelop.org"
}
