resource "aws_api_gateway_rest_api" "training" {
  name = "terraform-training-api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "events" {
  rest_api_id = aws_api_gateway_rest_api.training.id
  parent_id   = aws_api_gateway_rest_api.training.root_resource_id
  path_part   = "events"
}

resource "aws_api_gateway_method" "events_post" {
  rest_api_id   = aws_api_gateway_rest_api.training.id
  resource_id   = aws_api_gateway_resource.events.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "events_post" {
  rest_api_id = aws_api_gateway_rest_api.training.id
  resource_id = aws_api_gateway_resource.events.id
  http_method = aws_api_gateway_method.events_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"

  uri = aws_lambda_function.publish.invoke_arn
}

resource "aws_api_gateway_deployment" "training" {
  rest_api_id = aws_api_gateway_rest_api.training.id

  depends_on = [
    aws_api_gateway_integration.events_post
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "training" {
  rest_api_id   = aws_api_gateway_rest_api.training.id
  deployment_id = aws_api_gateway_deployment.training.id
  stage_name    = "dev"
}

output "api_gateway_url" {
  value = "http://localhost:4566/restapis/${aws_api_gateway_rest_api.training.id}/dev/_user_request_/events"
}
