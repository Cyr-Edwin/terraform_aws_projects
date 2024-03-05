output "bucket-name" {
  value = aws_s3_bucket.bucket.id
}

output "topic-arn" {
    value = aws_sns_topic.topic.arn
  
}