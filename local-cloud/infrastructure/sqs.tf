resource "aws_sqs_queue" "training" {
  name = "terraform-training-queue"

  tags = {
    Name = "terraform-training-queue"
  }
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

      Action = "sqs:SendMessage"

      Resource = aws_sqs_queue.training.arn

      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.training.arn
        }
      }
    }]
  })
}
