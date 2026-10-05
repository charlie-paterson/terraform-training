variable "api_name" {
  description = "HTTP API name"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Lambda invoke ARN used by the API integration"
  type        = string
}
