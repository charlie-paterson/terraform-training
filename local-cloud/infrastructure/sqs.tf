resource "aws_sqs_queue" "training" {
  name = "terraform-training-queue"

  tags = {
    Name = "terraform-training-queue"
  }
}
