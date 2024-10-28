output "create_ec2_instance_lambda_arn" {
  value = module.ec2.create_ec2_instance_lambda_arn
}

output "start_ec2_instance_lambda_arn" {
  value = module.ec2.start_ec2_instance_lambda_arn
}

output "stop_ec2_instance_lambda_arn" {
  value = module.ec2.stop_ec2_instance_lambda_arn
}

# output "lex_bot_arn" {
#   value = module.lex_bot.aws_lex_bot.NBCU_bot.arn
# }

output "lex_bot_arn" {
  value = module.lex_bot.lex_bot_arn
}
