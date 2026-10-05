variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN the Lambda role can publish to"
  type        = string
}

variable "ec2_ssm_role_name" {
  description = "IAM role name for EC2 SSM access"
  type        = string
}

variable "ec2_ssm_instance_profile_name" {
  description = "IAM instance profile name for EC2 SSM access"
  type        = string
}
