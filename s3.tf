resource "aws_s3_bucket" "lambda-s3" {
  bucket = "${var.account_id}-${var.prefix}-${var.s3_bucket_name}-${var.environment}"
  tags = {
    Name        = "${var.account_id}-${var.prefix}-${var.s3_bucket_name}-${var.environment}"
    Environment = "${var.environment}"
  }
}
