create = true
vpc_id = "vpc-06ab4d4d91b06b4c7"
vpc_cidr_block = "172.31.0.0/16"
gw_s3_endpoint = {
  create = true
  route_table_ids = ["rtb-083c954b3593bdf1a"]
}
ssm = {
  create = true
  aws_subnets_ids = ["subnet-0d9ab5110ee2a2f42"]
}
