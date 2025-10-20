resource "aws_s3_bucket" "my_cv_bucket" {
bucket = var.bucket_name
tags = var.tags

}

resource s3_bucket_public_access_block "my_cv_bucket_public_access" {
  bucket = aws_s3_bucket.my_cv_bucket.id
    block_public_acls       = true
    block_public_policy     = false
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource s3_website_configuration "my_cv_bucket_website" {
  bucket = aws_s3_bucket.my_cv_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource cloudfront_origin_access-control "my_cv_bucket_oac" {
  name            = "my-cv-bucket-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

resource cloudfront_distribution "my_cv_bucket_distribution" {
  origin {
    domain_name = aws_s3_bucket.my_cv_bucket.website_endpoint
    origin_id   = "S3-bucket-origin"
    cloudfront_origin_access_control_id = cloudfront_origin_access_control.my_cv_bucket_oac.id
  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribution for my CV S3 bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-bucket-origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags
}
