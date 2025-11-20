variable "secret_name" {
    type = string
    description = "name of the secret manager"
    sensitive = true 
}
variable "aws_region" {
    type = string
    description = "Application region"
    sensitive = true
}
variable "app_environment" {
    type = string
    description = "Application Environment"
}
variable "app_name" {
    type = string
    description = "Application Name"
}
variable "s3_bucket_name" {
    type = string
    description = "Name of the backend bucket"
    sensitive = true
}
variable "dynamodb_table_name" {
    type = string
    description = "Name of the dynamodbtable"
    sensitive = true
  
}