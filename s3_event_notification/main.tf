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
  bucket = "bucket-${random_string.random.result}"
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Development"
  }
}

# create an SNS Topic
resource "aws_sns_topic" "topic" {
  name = "s3-event"
  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[
        {
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
            }
        }
    ]
}
POLICY
}

# create SNS Topic Subcription
resource "aws_sns_topic_subscription" "topip_sub" {
    topic_arn = aws_sns_topic.topic.arn
    protocol = "email"
    endpoint = var.endpoint 
}

# create Bucket Event Notification
resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = aws_s3_bucket.bucket.id
    topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    
  } 
}