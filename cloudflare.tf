locals {
  cloudflare = {
    account_id = "09c8df40903546d43dba5a1924ee4b43"
    zones = {
      haxe-org = {
        zone_id = "01d9191b31046d86b5d7ba8f44c89b7c"
      }
    }
  }
}

resource "cloudflare_record" "acm-haxe-org-us-east-1-dns" {
  for_each = {
    for dvo in aws_acm_certificate.haxe-org-us-east-1-dns.domain_validation_options :
    dvo.resource_record_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }...
  }
  name    = each.value[0].name
  value   = each.value[0].record
  ttl     = 60
  type    = each.value[0].type
  zone_id = local.cloudflare.zones.haxe-org.zone_id
}

resource "cloudflare_record" "haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "haxe.org"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.haxe-org.domain_name
}

resource "cloudflare_record" "haxe-org-MX" {
  for_each = {
    "alt1.aspmx.l.google.com" = 5
    "alt2.aspmx.l.google.com" = 5
    "aspmx.l.google.com"      = 1
    "aspmx2.googlemail.com"   = 10
    "aspmx3.googlemail.com"   = 10
  }
  zone_id  = local.cloudflare.zones.haxe-org.zone_id
  name     = "haxe.org"
  type     = "MX"
  priority = each.value
  value    = each.key
  ttl      = 86400
}

resource "cloudflare_record" "haxe-org-TXT" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "haxe.org"
  type    = "TXT"
  value   = "v=spf1 include:spf.mailjet.com ?all"
  ttl     = 86400
}

resource "cloudflare_record" "mailjet-haxe-org-TXT" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "mailjet._domainkey"
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDvFphyZ+eTb+9mrswS/ClKwsacF9o+J76rzB3BWxWll3kfYnRtxauS98gpWG6jRkQiSdl02XS70SbSRXOEDYOXsAiEidySbyu45r5X1cto/w4h3MKT5EK1j1fYgQrHas3mNCIW9mB4I/GVfZ/CUnCluiw2zx3tnK4lbnGKvnE4JwIDAQAB"
  ttl     = 86400
}

# GitHub varification for https://github.com/HaxeFoundation/
resource "cloudflare_record" "github-challenge-haxe-org-TXT" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "_github-challenge-haxefoundation"
  type    = "TXT"
  value   = "cb2317691b"
  ttl     = 86400
}

# GitHub varification for https://github.com/haxelib/
resource "cloudflare_record" "github-challenge-lib-haxe-org-TXT" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "_github-challenge-haxelib.lib"
  type    = "TXT"
  value   = "6ea186783d"
  ttl     = 300
}

resource "cloudflare_record" "api-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "api"
  type    = "CNAME"
  value   = module.cloudfront_api-haxe-org.cloudfront_distribution_domain_name
}

resource "cloudflare_record" "benchs-haxe-org" {
  for_each = {
    A    = "5.196.93.21"
    AAAA = "2001:41d0:a:7c15::"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "benchs"
  type    = each.key
  value   = each.value
  ttl     = 300
}

resource "cloudflare_record" "blog-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "blog"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.blog-haxe-org.domain_name
}

resource "cloudflare_record" "build-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "build"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.build-haxe-org.domain_name
}

resource "cloudflare_record" "code-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "code"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.code-haxe-org.domain_name
}

resource "cloudflare_record" "community-haxe-org" {
  for_each = {
    A    = "152.228.170.54"
    AAAA = "2001:41d0:0304:0200:0000:b59a:0000:0000"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "community"
  type    = each.key
  value   = each.value
  ttl     = 86400
}

resource "cloudflare_record" "community-haxe-org-CAA" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "community"
  type    = "CAA"
  data {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }
  ttl = 300
}

resource "cloudflare_record" "hashlink-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "hashlink"
  type    = "CNAME"
  value   = "haxefoundation.github.io"
  ttl     = 86400
}

resource "cloudflare_record" "old-haxe-org" {
  for_each = {
    A = "5.39.76.185"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "old"
  type    = each.key
  value   = each.value
  ttl     = 86400
}

resource "cloudflare_record" "staging-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "staging"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.staging-haxe-org.domain_name
}

resource "cloudflare_record" "summit-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "summit"
  type    = "CNAME"
  value   = "haxefoundation.github.io"
  ttl     = 86400
}

resource "cloudflare_record" "tasks-haxe-org" {
  for_each = {
    A = "82.66.16.69"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "tasks"
  type    = each.key
  value   = each.value
  ttl     = 300
}

resource "cloudflare_record" "try-haxe-org" {
  for_each = {
    A    = "5.196.93.21"
    AAAA = "2001:41d0:a:7c15::"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "try"
  type    = each.key
  value   = each.value
  ttl     = 86400
}

resource "cloudflare_record" "www-haxe-org" {
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "www"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.www-haxe-org.domain_name
}

resource "cloudflare_record" "wwx-haxe-org" {
  for_each = {
    A = "213.186.33.17"
  }
  zone_id = local.cloudflare.zones.haxe-org.zone_id
  name    = "wwx"
  type    = each.key
  value   = each.value
  ttl     = 300
}
