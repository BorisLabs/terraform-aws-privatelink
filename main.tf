data "aws_region" "current" {}

resource "aws_vpc_endpoint_service" "name" {
  acceptance_required = var.acceptance_required

  network_load_balancer_arns = var.network_load_balancer_arns
  gateway_load_balancer_arns = var.gateway_load_balancer_arns

  tags = merge(var.service_tags, { Name = var.service_name })

  private_dns_name           = var.private_dns_name
  supported_ip_address_types = var.supported_ip_address_types
  supported_regions          = concat([data.aws_region.current.name], var.supported_regions)
}

resource "aws_vpc_endpoint_service_allowed_principal" "name" {
  for_each = { for k, v in var.allowed_principals : k => v }

  principal_arn           = lookup(each.value, "principal", null)
  vpc_endpoint_service_id = aws_vpc_endpoint_service.name.id
}

locals {
  tags = flatten([
    for details in var.allowed_principals : [
      for k, tags in details.tags : {
        principal = details.principal
        key       = tags.key
        value     = tags.value
      }
    ]
  ])

  tags_use = {
    for k, v in local.tags : k => v
  }
}

resource "aws_ec2_tag" "name" {
  for_each = local.tags_use

  key         = each.value.key
  value       = each.value.value
  resource_id = lookup({ for i in aws_vpc_endpoint_service_allowed_principal.name : i.principal_arn => i.id }, each.value.principal)
}

resource "aws_vpc_endpoint_connection_notification" "name" {
  count = var.enable_notifications ? 1 : 0

  vpc_endpoint_service_id = aws_vpc_endpoint_service.name.id

  connection_events           = var.endpoint_connection_notification_events
  connection_notification_arn = aws_sns_topic.name[0].arn
}

resource "aws_sns_topic" "name" {
  count = var.create_topic ? 1 : 0

  name   = "${var.service_name}-topic"
  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {
            "Service": "vpce.amazonaws.com"
        },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:vpce-notification-topic"
    }]
}
POLICY
}
