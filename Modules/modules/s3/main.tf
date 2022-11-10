resource "aws_s3_bucket" "sayeeshruthis3" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }
}