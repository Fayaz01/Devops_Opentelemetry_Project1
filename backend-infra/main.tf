resource "aws_s3_bucket" "terraform_s3_di" {
    bucket = var.s3_bucket_name
    lifecycle {
      prevent_destroy = false
    }
    tags = {
    Name                                           = "${var.cluster_name}-s3_buckett"
    "kubernetes.io/cluster/${var.cluster_name}"    = "shared"
  }
   
}

resource "aws_s3_bucket_public_access_block" "terraform_bucket_block" {
  bucket = aws_s3_bucket.terraform_s3_di.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
  
}
resource "aws_s3_bucket_versioning" "name" {
    bucket = aws_s3_bucket.terraform_s3_di.id
    versioning_configuration {
      status = "Enabled"
    }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
    bucket = aws_s3_bucket.terraform_s3_di.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name                                           = "${var.cluster_name}-dynamo-table"
    "kubernetes.io/cluster/${var.cluster_name}"    = "shared"
  }
}