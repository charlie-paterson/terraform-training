terraform {
  backend "local" {
    path = "/home/pater/terraform-state/local-cloud/terraform.tfstate"
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }

    aws = {
      source = "hashicorp/aws"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "docker" {}

provider "archive" {}

resource "docker_network" "local_cloud" {
  name = "${var.project_name}-${var.environment}"
}

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
}

module "database" {
  source = "./modules/database"

  project_name = var.project_name
  environment  = var.environment
  table_name   = var.dynamodb_table_name
}

module "messaging" {
  source = "./modules/messaging"

  topic_name = var.sns_topic_name
  queue_name = var.sqs_queue_name
}

moved {
  from = aws_vpc.training
  to   = module.networking.aws_vpc.training
}

moved {
  from = aws_subnet.training
  to   = module.networking.aws_subnet.training
}

moved {
  from = aws_security_group.training
  to   = module.networking.aws_security_group.training
}

moved {
  from = aws_dynamodb_table.training
  to   = module.database.aws_dynamodb_table.training
}

moved {
  from = aws_sns_topic.training
  to   = module.messaging.aws_sns_topic.training
}

moved {
  from = aws_sqs_queue.training
  to   = module.messaging.aws_sqs_queue.training
}

moved {
  from = aws_sns_topic_subscription.training_queue
  to   = module.messaging.aws_sns_topic_subscription.training_queue
}

moved {
  from = aws_sqs_queue_policy.training
  to   = module.messaging.aws_sqs_queue_policy.training
}
