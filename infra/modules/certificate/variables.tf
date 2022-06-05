variable "domain_name" {
  type        = string
  description = "The domain name we'd like to manage DNS for (e.g. timovink.com, timovink.ca, etc.)"
}

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the hosted zone for the given domain_name to create DNS validation records in"
}
