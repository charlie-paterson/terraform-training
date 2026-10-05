resource "aws_dynamodb_table" "training" {
  name         = "terraform-training"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "terraform-training-dynamodb"
  }
}
