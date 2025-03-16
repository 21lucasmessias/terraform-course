resource "aws_iam_user" "github_s3_user" {
  name = "github-s3-user"
}

resource "aws_iam_policy" "s3_put_policy" {
  name        = "S3PutObjectPolicy"
  description = "Permite apenas PutObject no bucket S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.lambda-s3.bucket}/*"
      },
      {
        Effect   = "Allow",
        Action   = "lambda:UpdateFunctionCode",
        Resource = "arn:aws:lambda:${var.aws_region}:${var.account_id}:function:${var.prefix}-${var.lambda_name}-*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.github_s3_user.name
  policy_arn = aws_iam_policy.s3_put_policy.arn
}

resource "aws_iam_access_key" "github_s3_user_key" {
  user = aws_iam_user.github_s3_user.name
}

output "aws_access_key_id" {
  value     = aws_iam_access_key.github_s3_user_key.id
  sensitive = true
}

output "aws_secret_access_key" {
  value     = aws_iam_access_key.github_s3_user_key.secret
  sensitive = true
}
