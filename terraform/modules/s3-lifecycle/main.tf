provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_lifecycle_configuration" "example" {
  rule {
    id      = "log-files"
    status  = "Enabled"
    prefix  = var.bucket_prefix
    enabled = true

    transition {
      days          = var.days
      storage_class = "GLACIER"
    }
  }
}