# vulnerable_s3s.tf
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-highly-vulnerable-unique-bucket-name-12345"
  acl    = "public-read" # This is the misconfiguration! Making an S3 bucket publicly readable is often a security risk.

  tags = {
    Environment = "Dev"
    Project     = "WizTest"
  }
}

resource "aws_s3_bucket_public_access_block" "example_block" {
  bucket = aws_s3_bucket.example_bucket.id

  # Even if these are set to true, "public-read" ACL will override them for read access.
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
