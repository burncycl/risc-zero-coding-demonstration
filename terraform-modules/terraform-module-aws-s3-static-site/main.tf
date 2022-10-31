# Create S3 Bucket 
resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = var.acl 
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.default.id
  policy = var.policy 
}
