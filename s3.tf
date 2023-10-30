resource "aws_s3_bucket" "basic_s3_bucket" {
  bucket        = var.s3_bucketname
  force_destroy = true
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.basic_s3_bucket.id

  depends_on = [aws_s3_bucket.basic_s3_bucket]

  topic {
    topic_arn = aws_sns_topic.sns_ue123.arn
    events    = ["s3:ObjectCreated:*"]
  }
}