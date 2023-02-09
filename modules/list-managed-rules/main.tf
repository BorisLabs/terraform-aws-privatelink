/*
Currently terraform doesn't support Cloudwatch insight rules, this is an option to list available templates for a VPC Endpoint service.  
AWS Provider issue here. https://github.com/hashicorp/terraform-provider-aws/issues/17877
*/
module "contributor_insights" {
  source  = "digitickets/cli/aws"
  version = "5.0.4"

  aws_cli_commands = ["cloudwatch", "list-managed-insight-rules", "--resource-arn ${var.service_arn}"]
}

// Locals for Cloudwatch contributor insights.
locals {
  contributor_templates = [for k, v in module.contributor_insights.result.ManagedRules : v["TemplateName"]]
}
