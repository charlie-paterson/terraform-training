resource "aws_vpc" "training" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_subnet" "training" {
  vpc_id     = aws_vpc.training.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.project_name}-${var.environment}-subnet"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_security_group" "training" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Terraform training security group"
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
    protocol     = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
