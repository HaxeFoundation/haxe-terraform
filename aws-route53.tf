resource "aws_route53_zone" "haxe-org" {
  name = "haxe.org"
}

resource "aws_route53_zone" "haxedevelop-org" {
  name = "haxedevelop.org"
}

resource "aws_route53_zone" "nekovm-org" {
  name = "nekovm.org"
}

resource "aws_route53_record" "acm-haxe-org-us-east-1-dns" {
  for_each = {
    for dvo in aws_acm_certificate.haxe-org-us-east-1-dns.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.haxe-org.zone_id
}

resource "aws_route53_record" "acm-nekovm-org-us-east-1-dns" {
  for_each = {
    for dvo in aws_acm_certificate.nekovm-org-us-east-1-dns.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.nekovm-org.zone_id
}

resource "aws_route53_record" "k8s-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "k8s"
  type    = "CNAME"
  ttl     = "86400"
  records = ["aws-k8s.haxe.org"]
}

resource "aws_route53_record" "prom-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "prom"
  type    = "CNAME"
  ttl     = "86400"
  records = ["aws-prom.haxe.org"]
}

resource "aws_route53_record" "grafana-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "grafana"
  type    = "CNAME"
  ttl     = "86400"
  records = ["aws-grafana.haxe.org"]
}

resource "aws_route53_record" "loki-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "loki"
  type    = "CNAME"
  ttl     = "86400"
  records = ["aws-loki.haxe.org"]
}
