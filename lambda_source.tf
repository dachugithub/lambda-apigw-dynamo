data "archive_file" "lambda_lambda_dynamodb" {
  type = "zip"

  source_file  = "${path.module}/dynamo-dblambda/lambda_dynamodb.py"
  output_path = "${path.module}/lambda_dynamodb.zip"
}

resource "aws_s3_object" "lambda_lambda_dynamodb" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambda_dynamodb.zip"
  source = data.archive_file.lambda_lambda_dynamodb.output_path

  etag = filemd5(data.archive_file.lambda_lambda_dynamodb.output_path)
}
