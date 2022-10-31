# Upload our awesome world renowned index.html
resource "aws_s3_object" "object" {
  bucket       = var.bucket_name
  key          = var.object
  source       = var.object
  etag         = filemd5(var.object)
  content_type = "text/html"
}
