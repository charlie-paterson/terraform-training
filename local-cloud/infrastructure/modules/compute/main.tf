resource "aws_instance" "training" {
  ami           = "ami-03cf127a"
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
