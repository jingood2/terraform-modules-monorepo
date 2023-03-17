module "vpc_test" {
  source = "../.."
  
  secondary_cidr_blocks = var.secondary_cidr_blocks
  private_subnets = var.vpc_private_subnets
}