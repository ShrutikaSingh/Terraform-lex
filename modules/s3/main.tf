# Lambda Function for S3 Bucket Creation
resource "aws_lambda_function" "create_s_three_bucket_lambda_function" {
  filename         = "modules/s3/create_s_three_bucket.zip"
  function_name    = "${var.project}-create-s-three-bucket"
  role             = var.lambda_exec_role_arn
  handler          = "create_s_three_bucket.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("modules/s3/create_s_three_bucket.zip")
  timeout          = var.lambda_timeout
}

# Permission for Lex to Invoke S3 Bucket Creation Lambda
resource "aws_lambda_permission" "allow_lex_create_s_three_invoke" {
  statement_id  = "AllowExecutionFromLex"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_s_three_bucket_lambda_function.function_name
  principal     = "lex.amazonaws.com"
  source_arn    = "arn:aws:lex:${var.aws_region}:${var.aws_account_id}:intent:create_s_three_bucket:$LATEST"
}

# CloudWatch Log Group for S3 Lambda
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.create_s_three_bucket_lambda_function.function_name}"
  retention_in_days = 14
}
