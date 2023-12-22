# TODO: Define the output variable for the lambda function.
output "response_lambda_function" {
  description = "output for the lambda function"
  value = aws_lambda_function.udacity_lambda.handler
}