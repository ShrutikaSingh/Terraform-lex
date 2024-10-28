# Outputs to expose Lambda ARNs
output "create_ec2_instance_lambda_arn" {
  value = aws_lambda_function.create_ec2_instance_lambda_function.arn
}

output "start_ec2_instance_lambda_arn" {
  value = aws_lambda_function.start_ec2_instance_lambda_function.arn
}

output "stop_ec2_instance_lambda_arn" {
  value = aws_lambda_function.stop_ec2_instance_lambda_function.arn
}
