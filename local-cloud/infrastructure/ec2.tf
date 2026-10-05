resource "aws_vpc" "training" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-training-vpc"
  }
}

resource "aws_subnet" "training" {
  vpc_id     = aws_vpc.training.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-training-subnet"
  }
}

resource "aws_security_group" "training" {
  name        = "terraform-training-sg"
  description = "Terraform training EC2 security group"
  vpc_id      = aws_vpc.training.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "training" {
  ami           = "ami-03cf127a"
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.training.id
  vpc_security_group_ids = [aws_security_group.training.id]

  iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name

  tags = {
    Name = "terraform-training-ec2"
  }
}
