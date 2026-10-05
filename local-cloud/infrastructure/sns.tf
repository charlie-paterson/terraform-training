resource "aws_sns_topic" "training" {
  name = "terraform-training-topic"

  tags = {
    Name = "terraform-training-topic"
  }
}

resource "aws_sns_topic_subscription" "training_queue" {
  topic_arn = aws_sns_topic.training.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.training.arn
}
