variable "primary_domain_name" {
  type        = string
  description = "The primary domain name we'd like to redirect all other requests to (e.g. timovink.dev)"
}

variable "secondary_domain_names" {
  type        = list(string)
  description = "The secondary domain names we'd like to redirect to the primary domain name (e.g. timovink.ca, timovink.app)"
}

variable "certificate_arns" {
  type        = map(string)
  description = "A map from domain names to ARNs of ACM certificates in the us-east-1 region"
}

variable "hosted_zone_ids" {
  type        = map(string)
  description = "A map from domain names to IDs of Hosted Zones"
}
