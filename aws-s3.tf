module "s3_bucket_terraform" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.2.3"

  bucket = "haxe-terraform"
  acl    = "private"

  versioning = {
    enabled = true
  }
}
