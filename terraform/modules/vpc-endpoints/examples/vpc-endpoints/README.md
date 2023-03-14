<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | ../.. | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region in which AWS Resources to be created | `string` | `"us-east-1"` | no |
| <a name="input_business_divsion"></a> [business\_divsion](#input\_business\_divsion) | Business Division in the large organization this Infrastructure belongs | `string` | `"share"` | no |
| <a name="input_codedeploy"></a> [codedeploy](#input\_codedeploy) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_codedeploy_commands_secure"></a> [codedeploy\_commands\_secure](#input\_codedeploy\_commands\_secure) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created | `bool` | `true` | no |
| <a name="input_dynamodb"></a> [dynamodb](#input\_dynamodb) | A map of dynamodb gateway endpoints containing their properties and configurations | `any` | <pre>{<br>  "create": false,<br>  "route_table_ids": [<br>    "id-1233445"<br>  ]<br>}</pre> | no |
| <a name="input_ec2"></a> [ec2](#input\_ec2) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_ec2messages"></a> [ec2messages](#input\_ec2messages) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_ecr_api"></a> [ecr\_api](#input\_ecr\_api) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_ecr_dkr"></a> [ecr\_dkr](#input\_ecr\_dkr) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_ecs"></a> [ecs](#input\_ecs) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_ecs_telemetry"></a> [ecs\_telemetry](#input\_ecs\_telemetry) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Variable used as a prefix | `string` | `"test"` | no |
| <a name="input_gw_s3_endpoint"></a> [gw\_s3\_endpoint](#input\_gw\_s3\_endpoint) | A map of s3 gateway endpoints containing their properties and configurations | `any` | <pre>{<br>  "create": false,<br>  "route_table_ids": []<br>}</pre> | no |
| <a name="input_kms"></a> [kms](#input\_kms) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_lambda"></a> [lambda](#input\_lambda) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Default security group IDs to associate with the VPC endpoints | `list(string)` | `[]` | no |
| <a name="input_selected_vpc_endpoints_tags"></a> [selected\_vpc\_endpoints\_tags](#input\_selected\_vpc\_endpoints\_tags) | Subnet ids of selected\_vpc\_endpoints\_tags | `list(string)` | `[]` | no |
| <a name="input_ssm"></a> [ssm](#input\_ssm) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false,<br>  "route_table_ids": null<br>}</pre> | no |
| <a name="input_ssmmessages"></a> [ssmmessages](#input\_ssmmessages) | A map of interface and/or gateway endpoints containing their properties and configurations | `map` | <pre>{<br>  "create": false<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Default subnets IDs to associate with the VPC endpoints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting VPC endpoint resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR of the VPC | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC in which the endpoint will be used | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_endpoints"></a> [vpc\_endpoints](#output\_vpc\_endpoints) | Array containing the full resource object and attributes for all endpoints created |
<!-- END_TF_DOCS -->