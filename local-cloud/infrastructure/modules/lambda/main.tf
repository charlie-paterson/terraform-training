data "archive_file" "publish_lambda" {
  type        = "zip"
  source_file = "${path.root}/../lambda/publish/index.py"
  output_path = "${path.root}/publish_lambda.zip"
}

resource "aws_lambda_function" "publish" {
  function_name = "${var.project_name}-publish"

  filename         = data.archive_file.publish_lambda.output_path
  source_code_hash = data.archive_file.publish_lambda.output_base64sha256

  handler = "index.handler"
  runtime = "python3.10"

  role = var.lambda_role_arn

  environment {
    variables = {
      SNS_TOPIC_ARN    = var.sns_topic_arn
      AWS_ENDPOINT_URL = var.aws_endpoint_url
      AWS_REGION       = var.aws_region
    }
  }

  tags = {
    Name = "${var.project_name}-publish"
  }
}

data "archive_file" "worker_lambda" {
  type        = "zip"
  source_file = "${path.root}/../lambda/worker/index.py"
  output_path = "${path.root}/worker_lambda.zip"
}

resource "aws_lambda_function" "worker" {
  function_name = "${var.project_name}-worker"

  filename         = data.archive_file.worker_lambda.output_path
  source_code_hash = data.archive_file.worker_lambda.output_base64sha256

  handler = "index.handler"
  runtime = "python3.10"

  role = var.lambda_role_arn

  environment {
    variables = {
      DYNAMODB_TABLE   = var.dynamodb_table_name
      AWS_ENDPOINT_URL = var.aws_endpoint_url
      AWS_REGION       = var.aws_region
    }
  }

  tags = {
    Name = "${var.project_name}-worker"
  }
}

resource "aws_lambda_event_source_mapping" "worker_sqs" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.worker.arn

  batch_size = 1
}
