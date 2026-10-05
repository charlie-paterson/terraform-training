output "ec2_ssm_instance_profile_name" {
  description = "EC2 SSM instance profile name"
  value       = aws_iam_instance_profile.ec2_ssm.name
}
