resource "aws_route53_zone" "this" {
  for_each = toset(var.domain_names)
  name     = each.key
}
