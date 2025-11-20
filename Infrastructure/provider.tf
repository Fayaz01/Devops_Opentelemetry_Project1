terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
  backend "s3" {
    bucket = "opentelemetry-di-s3-bucket"
    key = "infra/opentelemetry.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "opentelemetry-dynamodb-table"
    
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
    Environment = var.app_environment
    Name        = var.app_name
    Terraform   = true
  }
}
}
data "aws_secretsmanager_secret" "default" {
  name=var.secret_name
}
data "aws_secretsmanager_secret_version" "default" {
  secret_id = data.aws_secretsmanager_secret.default.id
}
locals {
  creds=sensitive(jsondecode(
    data.aws_secretsmanager_secret_version.default.secret_string
  ))
}

module "secret" {
    source = "../Application/modules/secrets"
    secret_name = var.secret_name 
}
module "backend" {
  source = "../Application/modules/secrets/backend"
  app_environment = local.creds.app_environment
  app_name = local.creds.app_name
  s3_bucket_name = local.creds.s3_bucket_name
  dynamodb_table_name = local.creds.dynamodb_table_name
  
}