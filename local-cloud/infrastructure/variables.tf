variable "aws_region" {
  description = "AWS region used by the local AWS emulator"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "terraform-training"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "local"
}

variable "vpc_cidr" {
  description = "CIDR block for the training VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the training subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
}
