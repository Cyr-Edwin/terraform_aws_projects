variable "secret_key" {
  type = string
  default="YOUR_SECRET_KEY"
}

variable "access_key" {
  type = string
  default="YOUR_ACCESS_KEY"
}

variable "endpoint" {
    description = "SNS Topic Subscription Endpoint"
    default="YOUR_EMAIL"
  
}

variable "region" {
    type = string
    default="us-eat-1"
}