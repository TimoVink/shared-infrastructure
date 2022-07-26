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
  domain_configs = {
    "timovink.dev" = [
      "timovink.com",
      "timovink.ca",
      "timovink.app"
    ],
    "jackievink.com" = [
      "jackievink.ca"
    ]
  }

  all_domain_names = concat(
    keys(local.domain_configs),
    flatten(values(local.domain_configs))
  )
}

module "iam" {
  source = "./modules/iam"

  admin_users = [
    "deployer",
    "tvink"
  ]
}

module "budget" {
  source = "./modules/budget"

  monthly_budget     = 10
  notification_email = "timovink@gmail.com"
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

module "domain_redirects" {
  for_each = local.domain_configs
  source   = "./modules/domain-redirects"

  primary_domain_name    = each.key
  secondary_domain_names = each.value

  certificate_arns = {
    for dn in each.value : dn => module.global_certificate[dn].certificate_arn
  }

  hosted_zone_ids = {
    for dn in each.value : dn => module.dns[dn].hosted_zone_id
  }
}
