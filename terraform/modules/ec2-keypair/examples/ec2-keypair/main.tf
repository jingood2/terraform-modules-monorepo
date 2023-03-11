module "example_ec2_keyapir" {
  source = "../.."

  key_name = var.key_name
}