variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}
