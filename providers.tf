terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.21"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.11"
    }
  }
  backend "s3" {
    bucket         = "haxe-terraform"
    key            = "haxe.tfstate"
    dynamodb_table = "haxe-terraform"
    # AWS_DEFAULT_REGION
    # AWS_ACCESS_KEY_ID
    # AWS_SECRET_ACCESS_KEY
  }
}

provider "aws" {
  # AWS_DEFAULT_REGION
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}

data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
data "aws_availability_zones" "available" {}
