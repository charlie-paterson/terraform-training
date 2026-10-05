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

data "archive_file" "worker_lambda" {
  type        = "zip"
  source_file = "${path.module}/../lambda/worker/index.py"
  output_path = "${path.module}/worker_lambda.zip"
}

resource "aws_lambda_function" "worker" {
  function_name = "terraform-training-worker"

  filename         = data.archive_file.worker_lambda.output_path
  source_code_hash = data.archive_file.worker_lambda.output_base64sha256

  handler = "index.handler"
  runtime = "python3.10"

  role = aws_iam_role.lambda.arn

  environment {
    variables = {
      DYNAMODB_TABLE = module.database.table_name
      AWS_ENDPOINT_URL = "http://172.17.0.2:4566"
      AWS_REGION       = "us-east-1"
    }
  }

  tags = {
    Name = "terraform-training-worker"
  }
}

resource "aws_lambda_event_source_mapping" "worker_sqs" {
  event_source_arn = aws_sqs_queue.training.arn
  function_name    = aws_lambda_function.worker.arn

  batch_size = 1
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowHttpApiInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.publish.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.training.execution_arn}/*/*"
}
