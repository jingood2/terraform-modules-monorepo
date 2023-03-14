module "vpc_endpoints" {
  source = "../.."

  create = var.create

  vpc_id             = var.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    // interface endpoint for s3
    /* s3 = {
      create = false
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    }, */
    // gateway endpoint for s3
    s3 = {
      create = lookup(var.gw_s3_endpoint,"create", false)
      service         = "s3"
      service_type    = "Gateway"
      //route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      route_table_ids = lookup(var.gw_s3_endpoint, "route_table_ids", null)
      policy          = data.aws_iam_policy_document.s3_endpoint_policy.json
      tags            = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      create = lookup(var.dynamodb,"create", false)
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = lookup(var.dynamodb, "route_table_ids", null)
      //route_table_ids = var.private_route_table_ids
      policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    ssm = {
      create = lookup(var.ssm,"create", false)
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ssmmessages = {
      create = lookup(var.ssmmessages,"create", false)
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
    lambda = {
      create = lookup(var.lambda,"create", false)
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
    ecs = {
      create = lookup(var.ecs,"create", false)
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
    ecs_telemetry = {
      create              = lookup(var.ecs_telemetry,"create", false)
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
    ec2 = {
      create              = lookup(var.ec2,"create", false)
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    ec2messages = {
      create              = lookup(var.ec2messages,"create", false)
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
    ecr_api = {
      create              = lookup(var.ecr_api,"create", false)
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    ecr_dkr = {
      create              = lookup(var.ecr_dkr,"create", false)
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    kms = {
      create              = lookup(var.kms,"create", false)
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
      security_group_ids  = [aws_security_group.vpc_tls.id]
    },
    codedeploy = {
      create              = lookup(var.codedeploy,"create", false)
      service             = "codedeploy"
      private_dns_enabled = true
      #subnet_ids          = module.vpc.private_subnets
      subnet_ids          = data.aws_subnets.selected.ids 
    },
    codedeploy_commands_secure = {
      create              = lookup(var.codedeploy_commands_secure,"create", false)
      service             = "codedeploy-commands-secure"
      private_dns_enabled = true
      subnet_ids          = data.aws_subnets.selected.ids
    },
  }

  tags = merge(local.common_tags, {
    Project  = "Secret"
    Endpoint = "true"
  })
}

/* module "vpc_endpoints_nocreate" {
  source = "../.."
  create = false
} */

################################################################################
# Supporting Resources
################################################################################

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    #values = [""] # insert values here
    values = var.selected_vpc_endpoints_tags
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = var.vpc_id
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [var.vpc_id]
    }
  }
}

data "aws_iam_policy_document" "s3_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [var.vpc_id]
    }
  }
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [var.vpc_id]
    }
  }
}

resource "aws_security_group" "vpc_tls" {
  name_prefix = "${local.name}-vpc_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = local.common_tags
}

