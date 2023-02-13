/*
Currently terraform doesn't support Cloudwatch insight rules, this is an option to enable contributor insights for a given VPC Endpoint service.  
AWS Provider issue here. https://github.com/hashicorp/terraform-provider-aws/issues/17877
*/
module "contributor_insights_enable" {
  for_each = toset(var.contributor_insights_template_list)

  source  = "digitickets/cli/aws"
  version = "5.0.4"

  aws_cli_commands = ["cloudwatch", "put-managed-insight-rules", "--managed-rules TemplateName=${each.key},ResourceARN=${var.service_arn},Tags=${var.tags}"]
}
