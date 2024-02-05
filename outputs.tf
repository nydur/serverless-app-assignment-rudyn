#Event 1
output "invoke_url" {
  description = "API Gateway URL"
  value       = aws_api_gateway_stage.example.invoke_url
}

#Event 2
output "invoke_arn" {
  description = "Function ARN"
  value       = aws_lambda_function.hello_lambda.invoke_arn
}

#Event 3
output "lambda_name" {
  description = "Function name"
  value       = aws_lambda_function.hello_lambda.function_name
}