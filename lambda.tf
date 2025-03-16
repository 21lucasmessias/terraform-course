resource "aws_lambda_function" "lambda_qa" {
  function_name = "${var.prefix}-${var.lambda_name}-${var.environment}"
  handler       = "lambda/index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.fc-lambda-role.arn
  s3_bucket     = aws_s3_bucket.lambda-s3.bucket
  s3_key        = "${var.lambda_name}-${var.lambda_version}.zip"
  timeout       = 10
  memory_size   = 128
}

output "lambda_qa_arn" {
  value = aws_lambda_function.lambda_qa.arn
}
