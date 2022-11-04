provider "aws" {
  region = "eu-west-1"
}

module "privatelink_service" {
  source = "../../"

  service_name = "demo-privatelink-service"

  nlb_name = "service-nlb"
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
  value = module.privatelink_service
}
