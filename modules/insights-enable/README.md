<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_contributor_insights_enable"></a> [contributor\_insights\_enable](#module\_contributor\_insights\_enable) | digitickets/cli/aws | 5.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contributor_insights_template_list"></a> [contributor\_insights\_template\_list](#input\_contributor\_insights\_template\_list) | A List of Managed Template Names to enable Contributor Insights | `list(string)` | <pre>[<br>  "VpcEndpointService-NewConnectionsByEndpointId-v1",<br>  "VpcEndpointService-BytesByEndpointId-v1",<br>  "VpcEndpointService-RstPacketsByEndpointId-v1",<br>  "VpcEndpointService-ActiveConnectionsByEndpointId-v1"<br>]</pre> | no |
| <a name="input_service_arn"></a> [service\_arn](#input\_service\_arn) | ARN of the AWS Privatelink Service | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be attached to the CloudWatch Insight Rules | `list(map(string))` | <pre>[<br>  {}<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rule_enabled_result"></a> [rule\_enabled\_result](#output\_rule\_enabled\_result) | Empty list if succesful, otherwise the error form the CLI will be displayed |
<!-- END_TF_DOCS -->