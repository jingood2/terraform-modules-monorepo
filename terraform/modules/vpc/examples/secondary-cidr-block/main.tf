module "vpc_test" {
  source = "../.."
  
  secondary_cidr_blocks = var.secondary_cidr_blocks
}