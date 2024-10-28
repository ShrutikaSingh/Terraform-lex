variable "aws_account_id" {
  default = "975049931675"  # Replace with your AWS account ID
}

variable "project" {
  default = "dev"  # Replace with your AWS account ID
}

variable "aws_region" {
  default = "us-east-1"  # Replace with your AWS region
}


variable "lambda_timeout" {
  description = "The timeout for the Lambda function in seconds."
  type        = number
  default     = 30  # You can set a default value here
}



# tfstate-> s3 