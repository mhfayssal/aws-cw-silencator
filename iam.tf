# This file contains the IAM role and policy for the Lambda function.
resource "aws_iam_policy" "lambda_policy" {
  name        = var.lambda_policy_name
  description = var.lambda_policy_description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function_name}:*"
      },
      {
        Action = [
          "cloudwatch:DescribeAlarms",
          "cloudwatch:DisableAlarmActions",
          "cloudwatch:EnableAlarmActions"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_role" {
  name        = var.lambda_role_name
  description = var.lambda_role_description
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  depends_on = [aws_iam_policy.lambda_policy, aws_cloudwatch_log_group.log_group_lambda]
}

# This file contains the IAM role policy attachment for the Lambda function.
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
