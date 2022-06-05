provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Project = "tv-sharedinfra"
    }
  }
}


locals {
  primary_domain_name = "timovink.dev"
  secondary_domain_names = [
    "timovink.com",
    "timovink.ca",
    "timovink.app"
  ]

  all_domain_names = concat([local.primary_domain_name], local.secondary_domain_names)
}


module "iam" {
  source = "./modules/iam"
}

module "dns" {
  source = "./modules/dns"

  domain_names = local.all_domain_names
}
