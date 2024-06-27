#create a S3 bucket with terraform with the name Davids3   

resource "aws_s3_bucket" "Davids3" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "Davids3"
    Environment = "Dev"
  }
}

#create a file with the content "this bucket is for testing" and upload it to the S3 bucket
locals {
  content = "this bucket is for testing"
}
resource "aws_s3_object" "testfile" {
  bucket  = aws_s3_bucket.Davids3.id
  key     = "test.txt"
  content = local.content
}
