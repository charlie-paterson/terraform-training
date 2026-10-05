aws_region   = "us-east-1"
project_name = "terraform-training"
environment  = "local"

vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

instance_type = "t3.micro"

dynamodb_table_name = "terraform-training"

sns_topic_name = "terraform-training-topic"
sqs_queue_name = "terraform-training-queue"
