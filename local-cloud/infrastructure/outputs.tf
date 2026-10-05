output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = module.database.table_name
}

output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = module.messaging.sqs_queue_url
}

output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = module.messaging.sns_topic_arn
}

output "api_gateway_url" {
  description = "API Gateway events endpoint"
  value       = module.api.api_url
}
