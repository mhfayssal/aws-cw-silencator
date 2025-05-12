# this file contains the lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/sources"
  output_path = "${path.module}/sources_zip/lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.lambda_function_name
  description      = var.lambda_description
  role             = aws_iam_role.lambda_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  publish          = var.lambda_publish
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  logging_config {
    log_format = "JSON"
  }
  depends_on = [aws_cloudwatch_log_group.log_group_lambda, aws_iam_role.lambda_role]
}
