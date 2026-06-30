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
