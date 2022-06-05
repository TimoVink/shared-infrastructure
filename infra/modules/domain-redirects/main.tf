resource "aws_cloudfront_function" "redirect" {
  name    = "tv-sharedinfra-redirecttoprimary"
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = <<-EOF
    function handler(event) {
        return {
            statusCode: 301,
            statusDescription: 'Moved Permanently',
            headers: {
                'location': { value: `https://${var.primary_domain_name}$${event.request.uri}` }
            }
        };
    }
  EOF
}

resource "aws_cloudfront_distribution" "this" {
  for_each = toset(var.secondary_domain_names)

  enabled = true
  aliases = [each.key]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "default"
    viewer_protocol_policy = "allow-all"

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.redirect.arn
    }
  }

  origin {
    origin_id   = "default"
    domain_name = var.primary_domain_name
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arns[each.key]
    ssl_support_method  = "sni-only"
  }
}
