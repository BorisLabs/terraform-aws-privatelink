resource "aws_vpc_endpoint_service" "name" {
  acceptance_required        = var.acceptance_required
  network_load_balancer_arns = [data.aws_lb.nlb.arn]

  tags = {
    Name = var.service_name
  }

  private_dns_name = var.private_dns_name

  supported_ip_address_types = ["ipv4"]
}

resource "aws_vpc_endpoint_service_allowed_principal" "name" {
  for_each = { for k, v in var.allowed_principals : k => v }

  principal_arn           = lookup(each.value, "principal", null)
  vpc_endpoint_service_id = aws_vpc_endpoint_service.name.id
}

data "aws_lb" "nlb" {
  name = var.nlb_name
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

resource "aws_ec2_tag" "name" {
  for_each = local.tags_use

  key         = each.value.key
  value       = each.value.value
  resource_id = aws_vpc_endpoint_service_allowed_principal.name[each.value.index].id
}

/*
resource "aws_sns_topic_policy" "name" {
  arn    = "value"
  policy = "value"
}
*/
