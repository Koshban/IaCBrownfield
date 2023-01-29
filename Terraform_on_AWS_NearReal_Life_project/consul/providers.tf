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
# Provider

provider "consul" {
  address    = "127.0.0.1:8500"
  datacenter = "dc1"
}

