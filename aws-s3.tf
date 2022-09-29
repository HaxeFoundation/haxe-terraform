module "s3_bucket_terraform" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket = "haxe-terraform"
  acl    = "private"

  versioning = {
    enabled = true
  }
}
