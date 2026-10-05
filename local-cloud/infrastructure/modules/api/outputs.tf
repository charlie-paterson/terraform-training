output "api_id" {
  description = "HTTP API ID"
  value       = aws_apigatewayv2_api.training.id
}

output "api_endpoint" {
  description = "HTTP API endpoint"
  value       = aws_apigatewayv2_api.training.api_endpoint
}

output "api_url" {
  description = "Events endpoint"
  value       = "${aws_apigatewayv2_api.training.api_endpoint}/events"
}

output "execution_arn" {
  description = "API execution ARN"
  value       = aws_apigatewayv2_api.training.execution_arn
}
