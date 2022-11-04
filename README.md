# terraform-aws-privatelink
AWS Privatelink module

# *** Note ***
This module supports the new AWS tagging feature for [Privatelink](https://aws.amazon.com/about-aws/whats-new/2022/09/aws-privatelink-announces-enhanced-tagging-capability-service-owners/), to use this feature a change to the AWS provider is required. There's currently a [PR](https://github.com/hashicorp/terraform-provider-aws/pull/27640) open to make this work. If you want to use this module you'll need to build the provider locally. See [Building Provider](Build.MD).

#

This terraform module creates the neccessary components for an AWS Privatelink service. 

```hcl
This module requires either a default profile to access AWS or use the environment variable AWS_PROFILE

terraform init
terraform apply --auto-approve
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_vpc_endpoint_service.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |
| [aws_lb.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acceptance_required"></a> [acceptance\_required](#input\_acceptance\_required) | Acceptance required on the privatelink access | `bool` | `true` | no |
| <a name="input_allowed_principals"></a> [allowed\_principals](#input\_allowed\_principals) | List of object, creates | <pre>list(object({<br>    principal = string<br>    tags      = optional(list(map(any)))<br>    index     = number<br>  }))</pre> | <pre>[<br>  {<br>    "index": 0,<br>    "principal": "arn:aws:iam::123456789012:root",<br>    "tags": [<br>      {<br>        "key": "Customer",<br>        "value": "Default1"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | Name of network loadbalancer | `string` | `null` | no |
| <a name="input_private_dns_name"></a> [private\_dns\_name](#input\_private\_dns\_name) | Private DNS name for endpoint | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the Endpoint service | `string` | `"default-name"` | no |
| <a name="input_service_tags"></a> [service\_tags](#input\_service\_tags) | Map of tags for the service | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_service"></a> [endpoint\_service](#output\_endpoint\_service) | n/a |
<!-- END_TF_DOCS -->