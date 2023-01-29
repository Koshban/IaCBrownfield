##################################################################################
# CONFIGURATION 
##################################################################################

terraform {
  required_version = "1.3.7"
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.0"
    }
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.0"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region  = var.aws_region
  profile = "deep-dive"
}

provider "consul" {
  address    = "${var.consul_address}:${var.consul_port}"
  datacenter = var.consul_datacenter
}

