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

variable "nlb_name" {
  description = "Name of network loadbalancer"
  default     = null

  type = string
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
  description = "List of object, creates "
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
