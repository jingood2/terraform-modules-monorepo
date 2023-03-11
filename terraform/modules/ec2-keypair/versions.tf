terraform {
  required_version = "~> 1.3.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx

  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}