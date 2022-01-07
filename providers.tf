terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.56"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.16"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.21"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.11"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
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

provider "digitalocean" {
  # DIGITALOCEAN_ACCESS_TOKEN
}

provider "aws" {
  # AWS_DEFAULT_REGION
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
data "aws_availability_zones" "available" {}

provider "github" {
  owner = "HaxeFoundation"
}
