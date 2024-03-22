variable "bucket_name" {
  description = "Name of the S3 bucket used for website hosting."
  default     = "silv-my-bucket"
}

variable "bucket_tags" {
  description = "Tags for S3 bucket."
  default = {
    Name        = "Silv s3 bucket"
    Environment = "Dev"
  }
}

variable "index_document_suffix" {
  description = "Suffix to the S3 bucket index document."
  default     = "index.html"
}

variable "object_ownership" {
  description = "Setting up object ownership in the S3 bucket."
  default     = "BucketOwnerPreferred"
}

variable "acl_setting" {
  description = "ACL configuration for the S3 bucket."
  default     = "public-read"
}

variable "s3_origin_id" {
  description = "ID for the S3 origin."
  default     = "myS3Origin"
}

variable "default_root_object" {
  description = "Default root object of the CloudFront distribution."
  default     = "index.html"
}

variable "ipv6_enabled" {
  description = "Flag to allow IPv6 for the CloudFront distribution."
  default     = true
}

variable "cache_behavior" {
  description = "Cache behavior for CloudFront distribution."
  default = {
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
  }
}