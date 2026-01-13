terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
  backend "s3" {
    bucket = "opentelemetry-s3-bucketfayaz"
    key = "infra/opentelemetry.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "opentelemetry_dyno"
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