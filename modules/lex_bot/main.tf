# Create EC2 Intent
resource "aws_lex_intent" "create_ec2_instance_intent" {
  name        = "create_ec_instance"
  description = "Intent to create instance"
  sample_utterances = ["Create a new instance", "Launch an  instance"]
  fulfillment_activity {
    type = "CodeHook"
    code_hook {
      message_version = "1.0"
      uri             = var.create_ec2_lambda_arn
    }
  }
  create_version = false
}

# Start EC2 Intent
resource "aws_lex_intent" "start_ec2_instance_intent" {
  name        = "start_ec_instance"
  description = "Intent to start instance"
  sample_utterances = ["Start my instance", "Launch the stopped instance", "Start EC Two Instance"]

  slot {
    name             = "instance_id"
    slot_type        = "AMAZON.AlphaNumeric"  # Replace with the correct slot type if needed
    slot_constraint  = "Required"
    value_elicitation_prompt {
      message {
        content_type = "PlainText"
        content      = "Please provide the instance ID you'd like to start."
      }
      max_attempts = 2
    }
  }

  fulfillment_activity {
    type = "CodeHook"
    code_hook {
      message_version = "1.0"
      uri             = var.start_ec2_lambda_arn
    }
  }
  create_version = false
}

# Stop EC2 Intent
resource "aws_lex_intent" "stop_ec2_instance_intent" {
  name        = "stop_ec_instance"
  description = "Intent to stop instance"
  sample_utterances = ["Stop my  instance", "Shut down the  instance"]
  
  slot {
    name             = "instance_id"
    slot_type        = "AMAZON.AlphaNumeric"  # Replace with the correct slot type if needed
    slot_constraint  = "Required"
    value_elicitation_prompt {
      message {
        content_type = "PlainText"
        content      = "Please provide the instance ID you'd like to stop."
      }
      max_attempts = 2
    }
  }

  fulfillment_activity {
    type = "CodeHook"
    code_hook {
      message_version = "1.0"
      uri             = var.stop_ec2_lambda_arn
    }
  }
  create_version = false
}

# S3 Bucket Creation Intent
resource "aws_lex_intent" "create_s_three_bucket_intent" {
  name        = "create_s_three_bucket"
  description = "Intent to create an S3 bucket"
  sample_utterances = [
    "Create an S three bucket",
    "Set up a new S Three bucket",
    "Create S three bucket"
  ]
  fulfillment_activity {
    type = "CodeHook"
    code_hook {
      message_version = "1.0"
      uri             = var.create_s_three_lambda_arn
    }
  }
  create_version = false
}


# Lex Bot Resource
resource "aws_lex_bot" "NBCU_bot" {
  name             = "NBCUBot"
  description      = "Bot for launching AES services"
  locale           = "en-US"
  voice_id         = "Joanna"
  process_behavior = "BUILD"
  child_directed   = false

  abort_statement {
    message {
      content      = "Sorry, I can't assist you at this time."
      content_type = "PlainText"
    }
  }

  clarification_prompt {
    max_attempts = 2
    message {
      content      = "I didn't understand that. Can you say it again?"
      content_type = "PlainText"
    }
  }

  # Linking the intents to the bot
  intent {
    intent_name    = aws_lex_intent.create_ec2_instance_intent.name
    intent_version = "$LATEST"
  }

  intent {
    intent_name    = aws_lex_intent.start_ec2_instance_intent.name
    intent_version = "$LATEST"
  }

  intent {
    intent_name    = aws_lex_intent.stop_ec2_instance_intent.name
    intent_version = "$LATEST"
  }

  intent {
    intent_name    = aws_lex_intent.create_s_three_bucket_intent.name
    intent_version = "$LATEST"
  }

  idle_session_ttl_in_seconds = 900
  create_version              = false
}

# output "lex_bot_arn" {
#   value = aws_lex_bot.NBCU_bot.arn
# }