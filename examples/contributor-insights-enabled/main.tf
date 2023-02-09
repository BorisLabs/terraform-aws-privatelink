provider "aws" {
  region = "eu-west-1"
}

data "aws_lb" "nlb" {
  name = "service-nlb"
}

module "privatelink_service" {
  source = "../../"

  service_name               = "demo-privatelink-service"
  network_load_balancer_arns = [data.aws_lb.nlb.arn]

  supported_ip_address_types = ["ipv4"]

  allowed_principals = [{
    principal = "arn:aws:iam::123456789012:root"
    index     = 0
    tags = [
      {
        key   = "Customer",
        value = "Demo1"
      },
      {
        key   = "Environment",
        value = "Demo-service"
      }
    ]
  }]
}

output "service" {
  value = module.privatelink_service.endpoint_service_details
}

module "insights_templates" {
  source = "../../modules/list-managed-rules"

  service_arn = module.privatelink_service.endpoint_service_arn
}

output "insights" {
  value = module.insights_templates
}

