resource "aws_acm_certificate" "haxe-org" {
  domain_name               = "haxe.org"
  subject_alternative_names = ["*.haxe.org"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "haxe-org-us-east-1-dns" {
  provider                  = aws.us-east-1
  domain_name               = "haxe.org"
  subject_alternative_names = ["*.haxe.org"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_acm_certificate_validation" "haxe-org-us-east-1-dns" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.haxe-org-us-east-1-dns.arn
  validation_record_fqdns = [for _, record in cloudflare_dns_record.acm-haxe-org-us-east-1-dns : record.name]
}

resource "aws_acm_certificate" "haxedevelop-org-us-east-1" {
  provider                  = aws.us-east-1
  domain_name               = "haxedevelop.org"
  subject_alternative_names = ["*.haxedevelop.org"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "nekovm-org-us-east-1" {
  provider          = aws.us-east-1
  domain_name       = "nekovm.org"
  validation_method = "EMAIL"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "nekovm-org-us-east-1-dns" {
  provider          = aws.us-east-1
  domain_name       = "nekovm.org"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_acm_certificate_validation" "nekovm-org-us-east-1-dns" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.nekovm-org-us-east-1-dns.arn
  validation_record_fqdns = [for record in aws_route53_record.acm-nekovm-org-us-east-1-dns : record.fqdn]
}
