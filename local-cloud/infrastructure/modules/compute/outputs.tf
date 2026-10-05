output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.training.id
}

output "instance_private_ip" {
  description = "EC2 private IP address"
  value       = aws_instance.training.private_ip
}
