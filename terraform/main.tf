resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
  force_destroy = true
  
  lifecycle {
    prevent_destroy = false
  }
  
  tags = {
    Name        = "Static website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.bucket_access_block]
  bucket     = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowCloudFrontService",
        "Effect": "Allow",
        "Principal": {
          "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*",
        "Condition": {
          "StringEquals": {
            "AWS:SourceArn": "${aws_cloudfront_distribution.distribution.arn}"
          }
        }
      }
    ]
  })
}

resource "aws_s3_object" "file" {
  for_each = fileset("${path.module}/../ready-html", "**/*.{html,css,js,woff2,png,min.js,jpg,jpeg}")
  bucket = aws_s3_bucket.bucket.id
  key    = replace(each.value, "^../ready-html/", "") 
  source = "${path.module}/../ready-html/${each.value}"
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  source_hash  = filemd5("${path.module}/../ready-html/${each.value}")
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }
}

