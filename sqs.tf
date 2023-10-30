resource "aws_sqs_queue" "ue123_sqs_lambda" {
  name                       = "ue123-terraform-lambda-sqs-queue"
  visibility_timeout_seconds = 60
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  sqs_managed_sse_enabled    = true

  tags = {
    Environment = "ue123"
  }
}
