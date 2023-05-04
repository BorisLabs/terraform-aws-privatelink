provider "aws" {
  region = "eu-west-1"
}

data "aws_lb" "nlb" {
  name = "demo-service-nlb"
}

module "privatelink_service" {
  source = "../../"

  service_name               = "demo-privatelink-service"
  network_load_balancer_arns = [data.aws_lb.nlb.arn]

  supported_ip_address_types = ["ipv4"]

  allowed_principals = [{
    principal = "arn:aws:iam::123456789012:root"
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
    },
    {
      principal = "arn:aws:iam::210987654321:root"
      tags = [
        {
          key   = "Customer",
          value = "Demo2"
        },
        {
          key   = "Environment",
          value = "Demo-service"
        }
      ]
    },
    {
      principal = "arn:aws:iam::123546789012:root"
      tags = [
        {
          key   = "Customer",
          value = "Demo3"
        },
        {
          key   = "Environment",
          value = "Demo-service"
        }
      ]
    }
  ]
}

output "service" {
  value = module.privatelink_service.tags
}

output "principals" {
  value = lookup(module.privatelink_service.principals, "arn:aws:iam::210987654321:root")
}
