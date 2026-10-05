resource "aws_dynamodb_table" "training" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-dynamodb"
    Project     = var.project_name
    Environment = var.environment
  }
}
