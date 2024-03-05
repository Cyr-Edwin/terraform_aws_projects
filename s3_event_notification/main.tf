provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  
}

# create Random String
resource "random_string" "random" {
    length = 6
    special = false
    upper = false
  
}

# Create an S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "s3_bucket${randomm_string.random}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Development"
  }
}
