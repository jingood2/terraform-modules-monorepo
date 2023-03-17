terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = "jingood2@sk.com"
}