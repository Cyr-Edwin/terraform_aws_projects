# create Random string
resource "random_string" "string" {
             length           = 6
             special          = false
             lower            = true
             upper            = false
             numeric           = true
              
}

# create a Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket-${random_string.string.result}"

}
  
# Create Bucket with public-read ACL
resource "aws_s3_bucket_public_access_block" "mybucket-acl" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# upload index.html file into the bucket
resource "aws_s3_object" "myobject-index" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

# upload error.html file into the bucket
resource "aws_s3_object" "myobject-erro" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
}

# create a website configuation into S3
resource "aws_s3_bucket_website_configuration" "mysite" {
  bucket = aws_s3_bucket.mybucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

# create a Bucket policy
resource "aws_s3_bucket_policy" "mybucket-policy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = <<EOF
{
  "Id": "Policy1710152822213",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow" ,
         "Principal": "*",
       "Action":["s3:GetObject"],
      "Resource": "${aws_s3_bucket.mybucket.arn}/*",
  
    }
  ]
}
EOF
}