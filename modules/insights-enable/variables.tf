variable "service_arn" {
  description = "ARN of the AWS Privatelink Service"
  default     = null

  type = string
}

variable "contributor_insights_template_list" {
  description = "A List of Managed Template Names to enable Contributor Insights"
  default = [
    "VpcEndpointService-NewConnectionsByEndpointId-v1",
    "VpcEndpointService-BytesByEndpointId-v1",
    "VpcEndpointService-RstPacketsByEndpointId-v1",
    "VpcEndpointService-ActiveConnectionsByEndpointId-v1"
  ]

  type = list(string)
}
