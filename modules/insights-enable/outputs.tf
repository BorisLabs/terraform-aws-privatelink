output "rule_enabled_result" {
  description = "Empty list if succesful, otherwise the error form the CLI will be displayed"
  value       = module.contributor_insights_enable.result
}
