provider "aws" {
  region = var.region
  access_key = "AKIAUVTDASA6L3CA5DXE"
  secret_key = "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"
}

# Generates an archive from content, a file, or a directory of files
data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "${path.module}/greet_lambda.zip"
}

# provision t2.micro EC2 instance
resource "aws_instance" "Udacity_T2" {
  count = "1"
  ami   = "ami-0fa1ca9559f1892ec"
  instance_type = "t2.micro"
  tags = {
    name = "Udacity T2"
  }
}

# create your actual Lambda function
resource "aws_lambda_function" "udacity_lambda" {
  function_name    = "udacity_lambda"
  filename         = data.archive_file.zip_the_python_code.output_path
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  handler          = "greet_lambda.lambda_handler"
  role             = var.role
  runtime          = "python3.8"
  vpc_config {
    subnet_ids = [var.aws_subnet]
    security_group_ids = [var.aws_security_group]
  }
}

resource "aws_cloudwatch_event_rule" "udacity_lambda" {
  name = "udacity_lambda"
  description = "Schedule Lambda-Funktion"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "udacity_lambda_function_target" {
  target_id = "udacity_lambda_function_target"
  rule = aws_cloudwatch_event_rule.udacity_lambda.name
  arn = aws_lambda_function.udacity_lambda.arn
}

resource "aws_lambda_permission" "udacity_allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.udacity_lambda.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.udacity_lambda.arn
}