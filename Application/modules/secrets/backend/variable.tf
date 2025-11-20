variable "s3_bucket_name" {
    type = string
    description = "Application bucket name for backend"
    sensitive = true 
}
variable "app_name" {
    type = string
    description = "Application name"
    sensitive = true
  
}
variable "app_environment" {
    type = string
    description = "Application environment name"
    sensitive = true
  
}
variable "dynamodb_table_name" {
    type = string
    description = "Name of the dynamodbtable"
    sensitive = true
  
}