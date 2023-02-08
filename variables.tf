variable "service_name" {
  description = "Name of the Endpoint service"
  type        = string
  default     = "default-name"
}

variable "service_tags" {
  description = "Map of tags for the service"
  type        = map(any)
  default     = {}
}

variable "network_load_balancer_arns" {
  description = "Arn of a network loadbalancer"
  default     = null

  type = list(string)
}

variable "gateway_load_balancer_arns" {
  description = "Arn of a Gateway Load balancer"
  default     = null

  type = list(string)
}

variable "private_dns_name" {
  description = "Private DNS name for endpoint"
  default     = null

  type = string
}

variable "acceptance_required" {
  description = "Acceptance required on the privatelink access"
  default     = true

  type = bool
}

variable "allowed_principals" {
  description = "Allowed principals to access your service, applies Tags to each principal"
  default = [
    {
      principal = "arn:aws:iam::123456789012:root"
      index     = 0
      tags = [
        {
          key   = "Customer"
          value = "Default1"
        }
      ]
    }
  ]

  type = list(object({
    principal = string
    tags      = optional(list(map(any)))
    index     = number
  }))
}

variable "supported_ip_address_types" {
  description = "List of Support IP Address Types"
  default     = ["ipv4"]

  type = list(string)
}

variable "endpoint_connection_notification_events" {
  description = "List of connection events on your service endpoint"
  default     = ["Accept", "Reject"]

  type = list(string)
}

variable "enable_notifications" {
  description = "Create Notifications for endpoint activity"
  default     = false

  type = bool
}

variable "create_topic" {
  description = "Create an SNS Topic to recieve notification events"
  default     = false

  type = bool
}
