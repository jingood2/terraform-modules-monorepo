<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | SSH Key pair Name | `string` | `"ap-northeast-2"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH Key pair Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example_ec2_keypair"></a> [example\_ec2\_keypair](#output\_example\_ec2\_keypair) | n/a |
<!-- END_TF_DOCS -->