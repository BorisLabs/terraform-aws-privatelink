output "endpoint_service_arn" {
  description = "VPC Endpoint Service ARN"
  value       = aws_vpc_endpoint_service.name.arn
}

output "endpoint_service_details" {
  description = "Object of all Outputs from the VPC Endpoint Service"
  value       = aws_vpc_endpoint_service.name
}

output "tags" {
  description = "Tags which where applied to the Service Principals"
  value       = local.tags_use
}

output "principals" {
  description = "Map of Principals to Service Endpoint ID"
  value       = { for principal in aws_vpc_endpoint_service_allowed_principal.name : principal.principal_arn => principal.id }
}
