# Stage 2 : Make a S3 bucket for web hosting.

resource "aws_s3_bucket" "s3bucket" {
  bucket = var.bucket_name

  tags = var.bucket_tags
}

# Stage 3: Set up the S3 bucket configuration
resource "aws_s3_bucket_website_configuration" "static_website_bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  index_document {
    suffix = var.index_document_suffix
  }
}

resource "aws_s3_bucket_ownership_controls" "static_website_bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_bucket" {
  bucket = aws_s3_bucket.s3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static_website_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_website_bucket,
    aws_s3_bucket_public_access_block.static_website_bucket,
  ]

  bucket = aws_s3_bucket.s3bucket.id
  acl    = var.acl_setting
}

# Stage 4: We set for the S3 bucket policy
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.s3bucket.arn,
          "${aws_s3_bucket.s3bucket.arn}/*"
        ]
      }
    ]
  })
}

# Stage 5: For this stage, upload webpage files to the S3 Bucket
resource "aws_s3_object" "website_files" {
  bucket       = aws_s3_bucket.s3bucket.id
  for_each     = fileset("website files/", "**/*.*")
  key          = each.value
  source       = "website files/${each.value}"
  content_type = each.value
}