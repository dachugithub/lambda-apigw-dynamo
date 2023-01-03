resource "aws_lambda_function" "lambda_dynamodb" {
  function_name = "LambdaDynamodb"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_lambda_dynamodb.key

  runtime = "python3.8"
  handler = "lambda_dynamodb.lambda_handler"

  source_code_hash = data.archive_file.lambda_lambda_dynamodb.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "lambda_dynamodb" {
  name = "/aws/lambda/${aws_lambda_function.lambda_dynamodb.function_name}"

  retention_in_days = 1
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "dynamodb_access_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.dynamoaccess.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
