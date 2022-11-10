resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = var.dynamodbname
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key = "lockid"
 
  attribute {
    name = "lockid"
    type = "S"
  }

  tags = {
    Name        = "terraform_lock_table"
    Environment = ""
  }
}