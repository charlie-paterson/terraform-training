output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.training.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.training.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.training.id
}
