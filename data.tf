data "iam_document_policy" "s3_read_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}
