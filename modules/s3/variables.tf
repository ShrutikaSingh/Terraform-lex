
variable "lambda_exec_role_arn" {
  description = "ARN for the Lambda execution role"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout for Lambda function in seconds"
  type        = number
  default     = 60
}

variable "project" {
  description = "Project name prefix for naming resources"
  type        = string
}
