variable "create_ec2_lambda_arn" {}
variable "start_ec2_lambda_arn" {}
variable "stop_ec2_lambda_arn" {}
variable "create_s_three_lambda_arn" {
  description = "ARN of the Lambda function to create S3 bucket"
  type        = string
}
