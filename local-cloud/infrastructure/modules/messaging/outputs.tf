output "sns_topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.training.arn
}

output "sns_topic_name" {
  description = "SNS topic name"
  value       = aws_sns_topic.training.name
}

output "sqs_queue_arn" {
  description = "SQS queue ARN"
  value       = aws_sqs_queue.training.arn
}

output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = aws_sqs_queue.training.url
}

output "sqs_queue_name" {
  description = "SQS queue name"
  value       = aws_sqs_queue.training.name
}
