# Create EC2 Instance Lambda Function
resource "aws_lambda_function" "create_ec2_instance_lambda_function" {
  filename         = "modules/ec2/create_ec2_instance.py.zip"
  function_name    = "CreateEC2Instance"
  role             = var.lambda_exec_role_arn
  handler          = "create_ec2_instance.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("modules/ec2/create_ec2_instance.py.zip")
  timeout          = var.lambda_timeout
}

# Permission for Lex to invoke CreateEC2Instance Lambda
resource "aws_lambda_permission" "allow_lex_create_ec2_invoke" {
  statement_id  = "AllowExecutionFromLex"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_ec2_instance_lambda_function.function_name
  principal     = "lex.amazonaws.com"
  source_arn    = "arn:aws:lex:${var.aws_region}:${var.aws_account_id}:intent:create_ec_instance:$LATEST"
}

# Start EC2 Instance Lambda Function
resource "aws_lambda_function" "start_ec2_instance_lambda_function" {
  filename         = "modules/ec2/start_ec2_instance.py.zip"
  function_name    = "StartEC2Instance"
  role             = var.lambda_exec_role_arn
  handler          = "start_ec2_instance.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("modules/ec2/start_ec2_instance.py.zip")
}

# Permission for Lex to invoke StartEC2Instance Lambda
resource "aws_lambda_permission" "allow_lex_start_ec2_invoke" {
  statement_id  = "AllowExecutionFromLex"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_ec2_instance_lambda_function.function_name
  principal     = "lex.amazonaws.com"
  source_arn    = "arn:aws:lex:${var.aws_region}:${var.aws_account_id}:intent:start_ec_instance:$LATEST"
}

# Stop EC2 Instance Lambda Function
resource "aws_lambda_function" "stop_ec2_instance_lambda_function" {
  filename         = "modules/ec2/stop_ec2_instance.py.zip"
  function_name    = "StopEC2Instance"
  role             = var.lambda_exec_role_arn
  handler          = "stop_ec2_instance.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("modules/ec2/stop_ec2_instance.py.zip")
}

# Permission for Lex to invoke StopEC2Instance Lambda
resource "aws_lambda_permission" "allow_lex_stop_ec2_invoke" {
  statement_id  = "AllowExecutionFromLex"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2_instance_lambda_function.function_name
  principal     = "lex.amazonaws.com"
  source_arn    = "arn:aws:lex:${var.aws_region}:${var.aws_account_id}:intent:stop_ec_instance:$LATEST"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.create_ec2_instance_lambda_function.function_name}"
  retention_in_days = 14  # Adjust retention period as needed
}
