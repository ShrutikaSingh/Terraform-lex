# Variables for AWS region, account ID, and Lambda timeout
variable "lambda_exec_role_arn" {}
variable "aws_account_id" {}
variable "aws_region" {}
variable "lambda_timeout" {
  description = "The timeout for the Lambda functions in seconds."
  type        = number
  default     = 900  # Set a default timeout value
}
