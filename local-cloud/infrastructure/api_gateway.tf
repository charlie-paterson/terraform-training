resource "aws_apigatewayv2_api" "training" {
  name          = "terraform-training-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "publish" {
  api_id = aws_apigatewayv2_api.training.id

  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.publish.invoke_arn

  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "events" {
  api_id    = aws_apigatewayv2_api.training.id
  route_key = "POST /events"

  target = "integrations/${aws_apigatewayv2_integration.publish.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.training.id
  name   = "dev"

  auto_deploy = true
}

output "api_gateway_url" {
  value = "${aws_apigatewayv2_api.training.api_endpoint}/events"
}
