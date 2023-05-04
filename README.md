# terraform-aws-privatelink
AWS Privatelink module

This terraform module creates the neccessary components for an AWS Privatelink service. 

```hcl
This module requires either a default profile to access AWS or use the environment variable AWS_PROFILE

terraform init
terraform apply --auto-approve
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

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
| [aws_sns_topic.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_vpc_endpoint_connection_notification.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_connection_notification) | resource |
| [aws_vpc_endpoint_service.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acceptance_required"></a> [acceptance\_required](#input\_acceptance\_required) | Acceptance required on the privatelink access | `bool` | `true` | no |
| <a name="input_allowed_principals"></a> [allowed\_principals](#input\_allowed\_principals) | Allowed principals to access your service, applies Tags to each principal | <pre>list(object({<br>    principal = string<br>    tags      = optional(list(map(any)))<br>  }))</pre> | <pre>[<br>  {<br>    "index": 0,<br>    "principal": "arn:aws:iam::123456789012:root",<br>    "tags": [<br>      {<br>        "key": "Customer",<br>        "value": "Default1"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_create_topic"></a> [create\_topic](#input\_create\_topic) | Create an SNS Topic to recieve notification events | `bool` | `false` | no |
| <a name="input_enable_notifications"></a> [enable\_notifications](#input\_enable\_notifications) | Create Notifications for endpoint activity | `bool` | `false` | no |
| <a name="input_endpoint_connection_notification_events"></a> [endpoint\_connection\_notification\_events](#input\_endpoint\_connection\_notification\_events) | List of connection events on your service endpoint | `list(string)` | <pre>[<br>  "Accept",<br>  "Reject"<br>]</pre> | no |
| <a name="input_gateway_load_balancer_arns"></a> [gateway\_load\_balancer\_arns](#input\_gateway\_load\_balancer\_arns) | Arn of a Gateway Load balancer | `list(string)` | `null` | no |
| <a name="input_network_load_balancer_arns"></a> [network\_load\_balancer\_arns](#input\_network\_load\_balancer\_arns) | Arn of a network loadbalancer | `list(string)` | `null` | no |
| <a name="input_private_dns_name"></a> [private\_dns\_name](#input\_private\_dns\_name) | Private DNS name for endpoint | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the Endpoint service | `string` | `"default-name"` | no |
| <a name="input_service_tags"></a> [service\_tags](#input\_service\_tags) | Map of tags for the service | `map(any)` | `{}` | no |
| <a name="input_supported_ip_address_types"></a> [supported\_ip\_address\_types](#input\_supported\_ip\_address\_types) | List of Support IP Address Types | `list(string)` | <pre>[<br>  "ipv4"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_service_arn"></a> [endpoint\_service\_arn](#output\_endpoint\_service\_arn) | VPC Endpoint Service ARN |
| <a name="output_endpoint_service_details"></a> [endpoint\_service\_details](#output\_endpoint\_service\_details) | Object of all Outputs from the VPC Endpoint Service |
| <a name="output_principals"></a> [principals](#output\_principals) | Map of Principals to Service Endpoint ID |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags which where applied to the Service Principals |
<!-- END_TF_DOCS -->