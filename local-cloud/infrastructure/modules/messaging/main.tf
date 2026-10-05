resource "aws_sns_topic" "training" {
  name = var.topic_name

  tags = {
    Name = var.topic_name
  }
}

resource "aws_sqs_queue" "training" {
  name = var.queue_name

  tags = {
    Name = var.queue_name
  }
}

resource "aws_sns_topic_subscription" "training_queue" {
  topic_arn = aws_sns_topic.training.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.training.arn
}

resource "aws_sqs_queue_policy" "training" {
  queue_url = aws_sqs_queue.training.url

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "sns.amazonaws.com"
      }

      Action   = "sqs:SendMessage"
      Resource = aws_sqs_queue.training.arn

      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.training.arn
        }
      }
    }]
  })
}
