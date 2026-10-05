resource "aws_sns_topic" "training" {
  name = "terraform-training-topic"

  tags = {
    Name = "terraform-training-topic"
  }
}
