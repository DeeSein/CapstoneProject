#create a S3 bucket with terraform with the name Davids3   

resource "aws_s3_bucket" "Davids3" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "Davids3"
    Environment = "Dev"
  }
}