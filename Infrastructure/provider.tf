terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

module "secret" {
    source = "../Application/modules/secrets"
    secret_name = var.secret_name
  
}