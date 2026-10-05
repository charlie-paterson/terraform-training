variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN used by the publish Lambda"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table used by the worker Lambda"
  type        = string
}

variable "sqs_queue_arn" {
  description = "SQS queue ARN used by the worker Lambda"
  type        = string
}

variable "aws_endpoint_url" {
  description = "AWS endpoint URL used by Lambda functions"
  type        = string
}

variable "aws_region" {
  description = "AWS region used by Lambda functions"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN used by the Lambda functions"
  type        = string
}
