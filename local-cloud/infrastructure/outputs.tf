output "dynamodb_table_name" {
  value = aws_dynamodb_table.training.name
}

output "sqs_queue_url" {
  value = aws_sqs_queue.training.url
}

output "sns_topic_arn" {
  value = aws_sns_topic.training.arn
}
