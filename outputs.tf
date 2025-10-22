output "s3_bucket_name" {
  value = aws_s3_bucket.my_cv_bucket.bucket
}

output "cloudfront_distribution_domain_name" {
  value = "https://${aws_cloudfront_distribution.my_cv_s3_distribution.domain_name}"
}



output "s3_bucket_id" {
  value = aws_s3_bucket_website_configuration.my_cv_bucket_website.id
}