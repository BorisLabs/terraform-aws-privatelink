<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_contributor_insights"></a> [contributor\_insights](#module\_contributor\_insights) | digitickets/cli/aws | 5.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_arn"></a> [service\_arn](#input\_service\_arn) | ARN of the AWS Privatelink Service | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_contributor_insight_rule_templates"></a> [contributor\_insight\_rule\_templates](#output\_contributor\_insight\_rule\_templates) | A list of available Contributor Insight Managed Rules |
| <a name="output_contributor_insights_rule_status"></a> [contributor\_insights\_rule\_status](#output\_contributor\_insights\_rule\_status) | Status of Contributor Insights on a given VPC Endpoint Service |
<!-- END_TF_DOCS -->