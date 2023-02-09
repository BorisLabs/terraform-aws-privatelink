output "endpoint_service_arn" {
  description = "VPC Endpoint Service ARN"
  value       = aws_vpc_endpoint_service.name.arn
}

output "endpoint_service_details" {
  description = "Object of all Outputs from the VPC Endpoint Service"
  value       = aws_vpc_endpoint_service.name
}

output "tags" {
  description = "Tags which where applied to the Service Principal"
  value       = local.tags_use
}
