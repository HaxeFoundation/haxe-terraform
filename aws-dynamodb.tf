resource "aws_dynamodb_table" "haxe-terraform" {
  name           = "haxe-terraform"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
