output "contributor_insight_rule_templates" {
  description = "A list of available Contributor Insight Managed Rules"
  value       = local.contributor_templates
}

output "contributor_insights_rule_status" {
  description = "Status of Contributor Insights on a given VPC Endpoint Service"
  value       = module.contributor_insights.result.ManagedRules
}
