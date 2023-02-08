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
  value = module.privatelink_service.endpoint_service
}
