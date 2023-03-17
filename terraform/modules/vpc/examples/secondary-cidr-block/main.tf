module "vpc_secondary_cidr_block" {
  source = "../.."
  
  secondary_cidr_blocks = var.secondary_cidr_blocks
}