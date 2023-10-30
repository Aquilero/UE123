terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = { # Der AWS Provider ermöglicht es AWS Resourcen zu erstellen
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# resource "aws_lambda_event_source_mapping" "sqs_event_source" {
#   event_source_arn = aws_sqs_queue.ue123_sqs_lambda.arn
#   function_name    = aws_lambda_function.sqs_lambda_function.arn
#   batch_size       = 1
# }
