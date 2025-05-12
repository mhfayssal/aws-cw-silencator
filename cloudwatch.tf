# This file contains the configuration for AWS CloudWatch resources.
resource "aws_cloudwatch_log_group" "log_group_lambda" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.lambda_log_group_retention
}
