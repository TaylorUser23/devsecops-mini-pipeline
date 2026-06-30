terraform {
  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for demonstration resources."
  type        = string
  default     = "us-east-1"
}

resource "aws_kms_key" "app_logs" {
  description             = "KMS key for DevSecOps mini pipeline demo logs"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "app_logs" {
  name          = "alias/devsecops-mini-pipeline-logs"
  target_key_id = aws_kms_key.app_logs.key_id
}

resource "aws_s3_bucket" "app_logs" {
  bucket = "devsecops-mini-pipeline-demo-logs"
}

resource "aws_s3_bucket_public_access_block" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.app_logs.arn
      sse_algorithm     = "aws:kms"
    }
  }
}