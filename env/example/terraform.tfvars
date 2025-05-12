aws_region  = "eu-west-3" #REGIOn TO DEPLOY YOUR INFRASTRUCTURE
aws_profile = "lg-prodexploit" #YOUR AWS PROFILE FOR DEPLOYMENT

#iam lambda
lambda_policy_name         = "lambda_io_alarm_policy" #IAM policy name for lambda
lambda_policy_description  = "lambda IO alarm policy" #IAM policy description for lambda
lambda_role_name           = "lambda_io_alarm_role" #IAM role name for lambda
lambda_role_description    = "lambda IO alarm role" #IAM role description for lambda
lambda_function_name       = "lambda_io_alarm" #IAM function name for lambda
lambda_description         = "Lambda IO Alarmes cloudwatch" #IAM function description for lambda
lambda_handler             = "lambda.handler" #IAM function handler for lambda
lambda_runtime             = "python3.12" #IAM function runtime for lambda
lambda_timeout             = 600 #IAM function timeout for lambda
lambda_memory_size         = 512 #IAM function memory size for lambda  
lambda_publish             = true #IAM function publish for lambda
lambda_log_group_retention = 7 #IAM function log group retention for lambda
