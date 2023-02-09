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
    for dvo in aws_acm_certificate.haxe-org-us-east-1-dns.domain_validation_options :
    dvo.resource_record_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }...
  }

  name    = each.value[0].name
  records = [each.value[0].record]
  ttl     = 60
  type    = each.value[0].type
  zone_id = aws_route53_zone.haxe-org.zone_id
}

resource "aws_route53_record" "acm-nekovm-org-us-east-1-dns" {
  for_each = {
    for dvo in aws_acm_certificate.nekovm-org-us-east-1-dns.domain_validation_options :
    dvo.resource_record_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }...
  }

  name    = each.value[0].name
  records = [each.value[0].record]
  ttl     = 60
  type    = each.value[0].type
  zone_id = aws_route53_zone.nekovm-org.zone_id
}

resource "aws_route53_record" "haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.haxe-org
    AAAA = aws_cloudfront_distribution.haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "haxe.org"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "haxe-org-MX" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "haxe.org"
  type    = "MX"
  records = [
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "1 ASPMX.L.GOOGLE.COM.",
    "10 ASPMX2.GOOGLEMAIL.COM.",
    "10 ASPMX3.GOOGLEMAIL.COM.",
  ]
  ttl = 86400
}

resource "aws_route53_record" "haxe-org-NS" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "haxe.org"
  type    = "NS"
  records = [
    "ns-124.awsdns-15.com.",
    "ns-1051.awsdns-03.org.",
    "ns-1800.awsdns-33.co.uk.",
    "ns-702.awsdns-23.net.",
  ]
  ttl = 86400
}

resource "aws_route53_record" "haxe-org-SOA" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "haxe.org"
  type    = "SOA"
  records = [
    "ns-124.awsdns-15.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
  ttl = 86400
}

resource "aws_route53_record" "haxe-org-TXT" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "haxe.org"
  type    = "TXT"
  records = [
    "v=spf1 include:spf.mailjet.com ?all",
  ]
  ttl = 86400
}

resource "aws_route53_record" "mailjet-haxe-org-TXT" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "mailjet._domainkey"
  type    = "TXT"
  records = [
    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDvFphyZ+eTb+9mrswS/ClKwsacF9o+J76rzB3BWxWll3kfYnRtxauS98gpWG6jRkQiSdl02XS70SbSRXOEDYOXsAiEidySbyu45r5X1cto/w4h3MKT5EK1j1fYgQrHas3mNCIW9mB4I/GVfZ/CUnCluiw2zx3tnK4lbnGKvnE4JwIDAQAB",
  ]
  ttl = 86400
}

# GitHub varification for https://github.com/HaxeFoundation/
resource "aws_route53_record" "github-challenge-haxe-org-TXT" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "_github-challenge-haxefoundation"
  type    = "TXT"
  records = [
    "cb2317691b",
  ]
  ttl = 86400
}

# GitHub varification for https://github.com/haxelib/
resource "aws_route53_record" "github-challenge-lib-haxe-org-TXT" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "_github-challenge-haxelib.lib"
  type    = "TXT"
  records = [
    "6ea186783d",
  ]
  ttl = 300
}

resource "aws_route53_record" "api-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "api"
  type    = "CNAME"
  records = ["haxefoundation.github.io"]
  ttl     = 86400
}

resource "aws_route53_record" "benchs-haxe-org" {
  for_each = {
    A    = "5.196.93.21"
    AAAA = "2001:41d0:a:7c15::"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "benchs"
  type    = each.key
  records = [each.value]
  ttl     = 300
}

resource "aws_route53_record" "blog-haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.blog-haxe-org
    AAAA = aws_cloudfront_distribution.blog-haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "blog"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "build-haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.build-haxe-org
    AAAA = aws_cloudfront_distribution.build-haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "build"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "code-haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.code-haxe-org
    AAAA = aws_cloudfront_distribution.code-haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "code"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "community-haxe-org" {
  for_each = {
    A    = "152.228.170.54"
    AAAA = "2001:41d0:0304:0200:0000:b59a:0000:0000"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "community"
  type    = each.key
  records = [each.value]
  ttl     = 86400
}

resource "aws_route53_record" "community-haxe-org-CAA" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "community"
  type    = "CAA"
  records = ["0 issue \"letsencrypt.org\""]
  ttl     = 300
}

resource "aws_route53_record" "hashlink-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "hashlink"
  type    = "CNAME"
  records = ["haxefoundation.github.io"]
  ttl     = 86400
}

resource "aws_route53_record" "old-haxe-org" {
  for_each = {
    A = "5.39.76.185"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "old"
  type    = each.key
  records = [each.value]
  ttl     = 86400
}

resource "aws_route53_record" "staging-haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.staging-haxe-org
    AAAA = aws_cloudfront_distribution.staging-haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "staging"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "summit-haxe-org" {
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "summit"
  type    = "CNAME"
  records = ["haxefoundation.github.io"]
  ttl     = 86400
}

resource "aws_route53_record" "tasks-haxe-org" {
  for_each = {
    A = "82.66.16.69"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "tasks"
  type    = each.key
  records = [each.value]
  ttl     = 300
}

resource "aws_route53_record" "try-haxe-org" {
  for_each = {
    A    = "5.196.93.21"
    AAAA = "2001:41d0:a:7c15::"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "try"
  type    = each.key
  records = [each.value]
  ttl     = 86400
}

resource "aws_route53_record" "www-haxe-org" {
  for_each = {
    A    = aws_cloudfront_distribution.www-haxe-org
    AAAA = aws_cloudfront_distribution.www-haxe-org
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "www"
  type    = each.key
  alias {
    name                   = each.value.domain_name
    zone_id                = each.value.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "wwx-haxe-org" {
  for_each = {
    A = "213.186.33.17"
  }
  zone_id = aws_route53_zone.haxe-org.zone_id
  name    = "wwx"
  type    = each.key
  records = [each.value]
  ttl     = 300
}
