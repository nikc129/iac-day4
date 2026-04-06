#asd#dfghjkflg#asdfghjk.
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "good" {
  bucket = "secure-bucket-demo-12345"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.good.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
