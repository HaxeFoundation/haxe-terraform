resource "aws_cloudfront_distribution" "haxe-org" {
  aliases             = ["haxe.org"]
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  default_root_object = "index.html"

  origin {
    domain_name = "haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_id   = "S3-Website-haxe.org.s3-website-eu-west-1.amazonaws.com/master"
    origin_path = "/master"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-Website-haxe.org.s3-website-eu-west-1.amazonaws.com/master"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = ["Origin"]
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "staging-haxe-org" {
  aliases             = ["staging.haxe.org"]
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  default_root_object = "index.html"

  origin {
    domain_name = "haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_id   = "S3-Website-haxe.org.s3-website-eu-west-1.amazonaws.com/staging"
    origin_path = "/staging"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-Website-haxe.org.s3-website-eu-west-1.amazonaws.com/staging"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = ["Origin"]
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 300
    max_ttl     = 3000
  }

  custom_error_response {
    error_caching_min_ttl = 300
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "www-haxe-org" {
  aliases         = ["www.haxe.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "www.haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_id   = "S3-Website-www.haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_path = ""

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-Website-www.haxe.org.s3-website-eu-west-1.amazonaws.com"
    viewer_protocol_policy = "allow-all"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = false
    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "code-haxe-org" {
  aliases         = ["code.haxe.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "haxefoundation.github.io"
    origin_id   = "Custom-haxefoundation.github.io/code-cookbook"
    origin_path = "/code-cookbook"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "Custom-haxefoundation.github.io/code-cookbook"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH"
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 8640
    max_ttl     = 3153600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

module "cloudfront_api-haxe-org" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.4.0"

  aliases = ["api.haxe.org"]

  price_class = "PriceClass_All"

  create_origin_access_control = true
  origin_access_control = {
    s3_oac = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    s3 = {
      domain_name = module.s3_bucket_api-haxe-org.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = false
  }

  viewer_certificate = {
    acm_certificate_arn = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "hashlink-haxe-org" {
  aliases         = ["hashlink.haxe.org"]
  enabled         = false
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "haxefoundation.github.io"
    origin_id   = "Custom-haxefoundation.github.io/hashlink.haxe.org"
    origin_path = "/hashlink.haxe.org"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "Custom-haxefoundation.github.io/hashlink.haxe.org"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH"
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 8640
    max_ttl     = 3153600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

resource "aws_cloudfront_distribution" "nekovm-org" {
  aliases         = ["nekovm.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "nekovm.org.s3-eu-west-1.amazonaws.com"
    origin_id   = "S3-nekovm.org"
  }

  origin {
    domain_name = "haxefoundation.github.io"
    origin_id   = "Custom-haxefoundation.github.io/nekovm.org"
    origin_path = "/nekovm.org"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  ordered_cache_behavior {
    path_pattern     = "/*media/*"
    target_origin_id = "S3-nekovm.org"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH"
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  default_cache_behavior {
    target_origin_id       = "Custom-haxefoundation.github.io/nekovm.org"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "GET",
      "OPTIONS",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 8640
    max_ttl     = 3153600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.nekovm-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

resource "aws_cloudfront_distribution" "summit-haxe-org" {
  aliases         = ["summit.haxe.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "haxesummit2017.github.io"
    origin_id   = "Custom-haxesummit2017.github.io"
    origin_path = "/website"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "Custom-haxesummit2017.github.io"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH"
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 900
    max_ttl     = 7200
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

resource "aws_cloudfront_distribution" "build-haxe-org" {
  aliases         = ["build.haxe.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"

  origin {
    domain_name = "t3oujumflj.execute-api.eu-west-1.amazonaws.com"
    origin_id   = "Custom-t3oujumflj.execute-api.eu-west-1.amazonaws.com/dev"
    origin_path = "/dev"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  origin {
    domain_name = "hxbuilds.s3-website-us-east-1.amazonaws.com"
    origin_id   = "S3-Website-hxbuilds.s3-website-us-east-1.amazonaws.com"
    origin_path = ""

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  ordered_cache_behavior {
    path_pattern     = "*_latest.*"
    target_origin_id = "S3-Website-hxbuilds.s3-website-us-east-1.amazonaws.com"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 600
  }

  ordered_cache_behavior {
    path_pattern     = "*.zip"
    target_origin_id = "S3-Website-hxbuilds.s3-website-us-east-1.amazonaws.com"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 864000
    max_ttl                = 31536000
  }

  ordered_cache_behavior {
    path_pattern     = "*.tar.gz"
    target_origin_id = "S3-Website-hxbuilds.s3-website-us-east-1.amazonaws.com"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 864000
    max_ttl                = 31536000
  }

  ordered_cache_behavior {
    path_pattern     = "*.nupkg"
    target_origin_id = "S3-Website-hxbuilds.s3-website-us-east-1.amazonaws.com"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 864000
    max_ttl                = 31536000
  }

  default_cache_behavior {
    target_origin_id       = "Custom-t3oujumflj.execute-api.eu-west-1.amazonaws.com/dev"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "GET",
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 600
    max_ttl     = 600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

resource "aws_cloudfront_distribution" "blog-haxe-org" {
  aliases         = ["blog.haxe.org"]
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  origin {
    domain_name = "blog.haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_id   = "S3-Website-blog.haxe.org.s3-website-eu-west-1.amazonaws.com"
    origin_path = ""

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-Website-blog.haxe.org.s3-website-eu-west-1.amazonaws.com"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = [
      "HEAD",
      "DELETE",
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "PATCH"
    ]
    cached_methods = [
      "HEAD",
      "GET",
    ]
    forwarded_values {
      headers                 = []
      query_string            = false
      query_string_cache_keys = []
      cookies {
        forward           = "none"
        whitelisted_names = []
      }
    }
    compress    = true
    min_ttl     = 0
    default_ttl = 86400
    max_ttl     = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.haxe-org-us-east-1-dns.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }
}

# TODO: terraform import aws_cloudfront_distribution.haxedevelop-org EM3IECFGY3XF0
# resource "aws_cloudfront_distribution" "haxedevelop-org" {
#   aliases = ["haxedevelop.org"]
# }

# TODO: terraform import aws_cloudfront_distribution.www-haxedevelop-org E13SJQASHEWH2G
# resource "aws_cloudfront_distribution" "www-haxedevelop-org" {
#   aliases = ["www.haxedevelop.org"]
# }
