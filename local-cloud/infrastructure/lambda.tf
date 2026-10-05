data "archive_file" "publish_lambda" {
  type        = "zip"
  source_file = "${path.module}/../lambda/publish/index.py"
  output_path = "${path.module}/publish_lambda.zip"
}

resource "aws_lambda_function" "publish" {
  function_name = "terraform-training-publish"

  filename         = data.archive_file.publish_lambda.output_path
  source_code_hash = data.archive_file.publish_lambda.output_base64sha256

  handler = "index.handler"
  runtime = "python3.10"

  role = aws_iam_role.lambda.arn

  environment {
    variables = {
      SNS_TOPIC_ARN    = aws_sns_topic.training.arn
      AWS_ENDPOINT_URL = "http://172.17.0.2:4566"
      AWS_REGION       = "us-east-1"
    }
  }

  tags = {
    Name = "terraform-training-publish"
  }
}
