resource "aws_iam_policy" "dynamoaccess" {
  name        = "minimal-dynamo-access"
  description = "Policy for lambda to access dynamodb"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:ListTables",
        "dynamodb:PutItem"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:dynamodb:eu-west-2:231770106020:table/*"
    }
  ]
}
EOF
}
