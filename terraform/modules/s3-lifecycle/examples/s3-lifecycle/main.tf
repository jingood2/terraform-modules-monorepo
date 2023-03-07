module "s3_with_lifecycle_example" {
  source = "../.."

  bucket_name = var.bucket_name
  days = var.days
  bucket_prefix =  var.bucket_prefix
}