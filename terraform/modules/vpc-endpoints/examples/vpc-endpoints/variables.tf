###########################################################################
# General Input Variables
###########################################################################

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "test"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "share"
}

###########################################################################
# Endpoint Input Variables
###########################################################################

variable "create" {
  description = "Determines whether resources will be created"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The ID of the VPC in which the endpoint will be used"
  type        = string
  default     = null
}

variable "vpc_cidr_block" {
  description = "CIDR of the VPC"
  type        = string
  default     = null
}

/* variable "endpoints" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = any
  default     = {}
} */

variable "gw_s3_endpoint" {
  description = "A map of s3 gateway endpoints containing their properties and configurations"
  type = any 
  default = {
    create = false
    route_table_ids = []
    //service         = "s3"
    //service_type    = "Gateway"
    //route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
    //policy          = data.aws_iam_policy_document.s3_endpoint_policy.json
    //tags            = { Name = "s3-vpc-endpoint" }
  }
}

variable "dynamodb" {
  description = "A map of dynamodb gateway endpoints containing their properties and configurations"
  type = any 
  default = {
    create = false
    route_table_ids = ["id-1233445"]
    //service         = "s3"
    //service_type    = "Gateway"
    //route_table_ids = flatten([module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
    //policy          = data.aws_iam_policy_document.s3_endpoint_policy.json
    //tags            = { Name = "s3-vpc-endpoint" }
  }
}

variable "ssm" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
    route_table_ids = null
  }
}

variable "ssmmessages" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "lambda" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ecs" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ecs_telemetry" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ec2" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ec2messages" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ecr_api" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "ecr_dkr" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "kms" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "codedeploy" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "codedeploy_commands_secure" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map
  default = {
    create = false
  }
}

variable "security_group_ids" {
  description = "Default security group IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Default subnets IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting VPC endpoint resources"
  type        = map(string)
  default     = {}
}

variable "selected_vpc_endpoints_tags" {
  description = "Subnet ids of selected_vpc_endpoints_tags"
  type        = list(string)
  default     = []
  
}