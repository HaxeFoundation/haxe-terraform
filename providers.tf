terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.39"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    gandi = {
      source  = "go-gandi/gandi"
      version = "~> 2.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.14"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "~> 2.19"
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
  app_auth {
    id              = 314905
    installation_id = 36157157
    pem_file        = data.aws_ssm_parameter.haxe-terraform-github-app-pem.value
  }
}

provider "gandi" {
  # Personal Access Token (haxe-terraform) permissions:
  #  - See and renew domain names
  #  - Manage domain name technical configurations
  personal_access_token = data.aws_ssm_parameter.gandi_personal_access_token.value
}

provider "cloudflare" {
  api_token = data.aws_ssm_parameter.cloudflare_api_token.value
}
