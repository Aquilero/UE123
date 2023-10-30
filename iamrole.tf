resource "aws_iam_role" "lambda_role" {
  name = "terraform_aws_lambda_role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_policy" "iam_policy_for_lambda2" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role2"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "s3:PutObject",
          "Resource" : "${aws_s3_bucket.basic_s3_bucket.arn}/*"
        }
      ]
    }
  )
}

resource "aws_iam_policy" "iam_policy_for_sqs" {
  name        = "aws_iam_policy_for_sqs"
  description = "AWS IAM Policy for SQS to receive messages from S3"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "sqs:*",
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_policy" "iam_policy_for_dynamodb" {
  name        = "aws_iam_policy_for_terraform_aws_dynamoDB_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws dynamoDB role"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "dynamodb:PutItem",
        "Resource" : "${aws_dynamodb_table.basic-dynamodb-table.arn}"
      },
    ],
  })
}


resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_for_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_lambda_role_sqs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_sqs.arn
}
