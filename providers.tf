terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.17"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.20"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
    gandi = {
      source = "go-gandi/gandi"
      version = "~> 2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.16"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.17"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
    grafana = {
      source = "grafana/grafana"
      version = "~> 1.23"
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
  # SPACES_ACCESS_KEY_ID
  # SPACES_SECRET_ACCESS_KEY
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

provider "gandi" {
  key = data.aws_ssm_parameter.gandi_api_key.value
}

provider "cloudflare" {
  api_token = data.aws_ssm_parameter.cloudflare_api_token.value
}
