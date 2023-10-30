resource "aws_sns_topic" "sns_ue123" {
  name = "sns_ue123"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.sns_ue123.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_dynamodb_function.arn
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.sns_ue123.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.ue123_sqs_lambda.arn
}
