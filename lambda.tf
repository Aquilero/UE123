resource "aws_lambda_function" "lambda_dynamodb_function" {
  filename      = "${path.module}/python/function.zip"
  function_name = "function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "function.lambda_handler"
  runtime       = "python3.11"
}

data "archive_file" "zip_the_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/function.zip"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dynamodb_function.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dynamodb_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.sns_ue123.arn
}