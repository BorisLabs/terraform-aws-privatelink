resource "aws_vpc_endpoint_service" "name" {
  acceptance_required = var.acceptance_required

  network_load_balancer_arns = var.network_load_balancer_arns
  gateway_load_balancer_arns = var.gateway_load_balancer_arns

  tags = merge(var.service_tags, { Name = var.service_name })

  private_dns_name           = var.private_dns_name
  supported_ip_address_types = var.supported_ip_address_types
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
        index     = details.index
      }
    ]
  ])

  tags_use = {
    for k, v in local.tags : k => v
  }
}

/* 
Temporary use of the cli until PR https://github.com/hashicorp/terraform-provider-aws/pull/27640 is merged
This is used to get the correct servicePermissionId to allow tags to be applied to Principals on the privatelink
Only used if tags are being set on within the var.allowed_principals
*/

module "tag_allowed_principals" {
  count = length(keys(local.tags_use)) > 0 ? 1 : 0

  source  = "digitickets/cli/aws"
  version = "5.0.4"

  aws_cli_commands = ["ec2", "describe-vpc-endpoint-service-permissions", "--service-id ${aws_vpc_endpoint_service.name.id}"]
  aws_cli_query    = "AllowedPrincipals[0].ServicePermissionId"
}

resource "aws_ec2_tag" "name" {
  for_each = local.tags_use

  key         = each.value.key
  value       = each.value.value
  resource_id = element(module.tag_allowed_principals[0].result, each.value.index)
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
