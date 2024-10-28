
# IAM Role for Lambda Execution
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

# IAM Role Policy for EC2 management
# and allow lambda to create cloudwatch logs
resource "aws_iam_role_policy" "lambda_exec_policy" {
  name = "lambda_exec_policy"
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
   Statement = [
      {
        Action   = [
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances",
          "ec2:DescribeImages"  # Add this permission
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Lambda Functions Module - Passing IAM Role ARN
module "ec2" {
  source              = "./modules/ec2"
  lambda_exec_role_arn = aws_iam_role.lambda_exec_role.arn
  aws_account_id       = var.aws_account_id
  aws_region           = var.aws_region
}


# Lambda Functions Module for S3 Bucket Creation
module "s3" {
  source               = "./modules/s3"
  lambda_exec_role_arn = aws_iam_role.lambda_exec_role.arn
  aws_account_id       = var.aws_account_id
  aws_region           = var.aws_region
  project              = var.project              # Add this line
  lambda_timeout       = var.lambda_timeout       # If lambda_timeout is required
}


# Lex Bot Module
module "lex_bot" {
  source = "./modules/lex_bot"
  create_ec2_lambda_arn = module.ec2.create_ec2_instance_lambda_arn
  start_ec2_lambda_arn  = module.ec2.start_ec2_instance_lambda_arn
  stop_ec2_lambda_arn   = module.ec2.stop_ec2_instance_lambda_arn
  create_s_three_lambda_arn  = module.s3.create_s_three_bucket_lambda_arn  # Add this line
}

