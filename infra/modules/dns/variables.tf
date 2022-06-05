variable "domain_names" {
  type        = list(string)
  description = "A list of all the domain names we'd like to manage DNS for (e.g. timovink.com, timovink.ca, etc.)"
}
