# terraform-aws-privatelink
AWS Privatelink module

# *** Note ***
This module supports the new AWS tagging feature for [Privatelink](https://aws.amazon.com/about-aws/whats-new/2022/09/aws-privatelink-announces-enhanced-tagging-capability-service-owners/), to make use of this feature a change to the AWS provider is required. There's currently a [PR](https://github.com/hashicorp/terraform-provider-aws/pull/27640) open to make this work. As a temporary workaround I'm using a submodule that invokes the AWS CLI, this module requires both AWS CLI & JQ installed & available. See [digitickets/cli/aws](https://registry.terraform.io/modules/digitickets/cli/aws/latest) for more details on module usage.
#

This terraform module creates the neccessary components for an AWS Privatelink service. 

```hcl
This module requires either a default profile to access AWS or use the environment variable AWS_PROFILE

terraform init
terraform apply --auto-approve
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 0.13)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (4.34.0)

## Modules

The following Modules are called:

### <a name="module_tag_allowed_principals"></a> [tag\_allowed\_principals](#module\_tag\_allowed\_principals)

Source: digitickets/cli/aws

Version: 5.0.4

## Resources

The following resources are used by this module:

- [aws_ec2_tag.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) (resource)
- [aws_sns_topic.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) (resource)
- [aws_vpc_endpoint_connection_notification.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_connection_notification) (resource)
- [aws_vpc_endpoint_service.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) (resource)
- [aws_vpc_endpoint_service_allowed_principal.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_acceptance_required"></a> [acceptance\_required](#input\_acceptance\_required)

Description: Acceptance required on the privatelink access

Type: `bool`

Default: `true`

### <a name="input_allowed_principals"></a> [allowed\_principals](#input\_allowed\_principals)

Description: Allowed principals to access your service, applies Tags to each principal

Type:

```hcl
list(object({
    principal = string
    tags      = optional(list(map(any)))
    index     = number
  }))
```

Default:

```json
[
  {
    "index": 0,
    "principal": "arn:aws:iam::123456789012:root",
    "tags": [
      {
        "key": "Customer",
        "value": "Default1"
      }
    ]
  }
]
```

### <a name="input_create_topic"></a> [create\_topic](#input\_create\_topic)

Description: Create an SNS Topic to recieve notification events

Type: `bool`

Default: `false`

### <a name="input_enable_notifications"></a> [enable\_notifications](#input\_enable\_notifications)

Description: Create Notifications for endpoint activity

Type: `bool`

Default: `false`

### <a name="input_endpoint_connection_notification_events"></a> [endpoint\_connection\_notification\_events](#input\_endpoint\_connection\_notification\_events)

Description: List of connection events on your service endpoint

Type: `list(string)`

Default:

```json
[
  "Accept",
  "Reject"
]
```

### <a name="input_gateway_load_balancer_arns"></a> [gateway\_load\_balancer\_arns](#input\_gateway\_load\_balancer\_arns)

Description: Arn of a Gateway Load balancer

Type: `list(string)`

Default: `null`

### <a name="input_network_load_balancer_arns"></a> [network\_load\_balancer\_arns](#input\_network\_load\_balancer\_arns)

Description: Arn of a network loadbalancer

Type: `list(string)`

Default: `null`

### <a name="input_private_dns_name"></a> [private\_dns\_name](#input\_private\_dns\_name)

Description: Private DNS name for endpoint

Type: `string`

Default: `null`

### <a name="input_service_name"></a> [service\_name](#input\_service\_name)

Description: Name of the Endpoint service

Type: `string`

Default: `"default-name"`

### <a name="input_service_tags"></a> [service\_tags](#input\_service\_tags)

Description: Map of tags for the service

Type: `map(any)`

Default: `{}`

### <a name="input_supported_ip_address_types"></a> [supported\_ip\_address\_types](#input\_supported\_ip\_address\_types)

Description: List of Support IP Address Types

Type: `list(string)`

Default:

```json
[
  "ipv4"
]
```

## Outputs

The following outputs are exported:

### <a name="output_endpoint_service"></a> [endpoint\_service](#output\_endpoint\_service)

Description: n/a
<!-- END_TF_DOCS -->