output "publish_function_name" {
  description = "Publish Lambda function name"
  value       = aws_lambda_function.publish.function_name
}

output "publish_function_arn" {
  description = "Publish Lambda function ARN"
  value       = aws_lambda_function.publish.arn
}

output "publish_invoke_arn" {
  description = "Publish Lambda invoke ARN"
  value       = aws_lambda_function.publish.invoke_arn
}

output "worker_function_name" {
  description = "Worker Lambda function name"
  value       = aws_lambda_function.worker.function_name
}

output "worker_function_arn" {
  description = "Worker Lambda function ARN"
  value       = aws_lambda_function.worker.arn
}
