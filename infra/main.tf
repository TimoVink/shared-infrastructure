provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Project = "tv-sharedinfra"
    }
  }
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"

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

  for_each    = toset(local.all_domain_names)
  domain_name = each.key
}

module "local_certificate" {
  source = "./modules/certificate"

  for_each       = toset(local.all_domain_names)
  domain_name    = each.key
  hosted_zone_id = module.dns[each.key].hosted_zone_id
}

module "global_certificate" {
  source    = "./modules/certificate"
  providers = { aws = aws.global }

  for_each       = toset(local.all_domain_names)
  domain_name    = each.key
  hosted_zone_id = module.dns[each.key].hosted_zone_id
}
