data "aws_route53_zone" "route53-zone" {
  name         = "goormedu-clone.com"
  private_zone = false
}

resource "aws_acm_certificate" "api-cert" {
  domain_name       = "*.goormedu-clone.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "api-cert-valid" {
  certificate_arn         = aws_acm_certificate.api-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api-route53-record : record.fqdn]
}

resource "aws_route53_record" "api-route53-record" {
  for_each = {
    for dvo in aws_acm_certificate.api-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53-zone.zone_id
}