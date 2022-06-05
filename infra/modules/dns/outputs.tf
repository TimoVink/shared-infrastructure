output "hosted_zone_id" {
  value       = aws_route53_zone.this.zone_id
  description = "ID of the Route 53 Hosted Zone created to manage DNS for this domain"
}
