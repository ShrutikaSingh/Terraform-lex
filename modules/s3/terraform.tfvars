# General configuration
project             = "myproject"            # Replace with your project name
env                 = "dev"                  # Set the environment (e.g., dev, prod)
suffix              = "001"                  # Any suffix to uniquely identify resources
component           = "lex-s3-bucket-creation"   # Component description

# Cost-related tags
cost_bucket         = "s3-cost-bucket"       # Billing tag for cost bucket
cost_bucket_project = "s3-cost-project"      # Billing tag for project

# AWS region configuration
region              = "us-east-1"            # AWS region

# Lambda settings
lambda_exec_role_arn = "arn:aws:iam::123456789012:role/lambda_exec_role"  # Replace with actual Lambda execution role ARN
lambda_timeout       = 300                    # Lambda function timeout (seconds)
