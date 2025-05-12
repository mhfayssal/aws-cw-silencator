
variable "aws_profile" {
  description = "AWS profile to use"
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}


variable "lambda_policy_name" {
  description = "Name of the IAM policy for Lambda functions"
}

variable "lambda_policy_description" {
  description = "Description of the IAM policy for Lambda functions"
}

variable "lambda_role_name" {
  description = "Name of the IAM role for Lambda functions"
}

variable "lambda_role_description" {
  description = "Description of the IAM role for Lambda functions"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
}

variable "lambda_handler" {
  description = "Handler of the Lambda function"
}

variable "lambda_runtime" {
  description = "Runtime of the Lambda function"
}

variable "lambda_timeout" {
  description = "Timeout of the Lambda function"
}

variable "lambda_memory_size" {
  description = "Memory size of the Lambda function"
}

variable "lambda_publish" {
  description = "Publish the Lambda function"
}

variable "lambda_log_group_retention" {
  description = "Retention in days of the CloudWatch log group"
}

variable "lambda_description" {
  description = "Description of the Lambda function"
  type        = string
}
