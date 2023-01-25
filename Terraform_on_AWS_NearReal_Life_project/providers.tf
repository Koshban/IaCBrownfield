terraform {
  required_version = "1.3.7"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.0"
    }
  }
}
# Provider
provider "aws" {
  region  = var.aws_region
  profile = "deep-dive"
}

