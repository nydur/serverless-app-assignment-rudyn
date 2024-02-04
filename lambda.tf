data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.your_name}-lambda-hw-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "hello_lambda" {
  function_name    = "${var.your_name}-hello-world-terraform"
  filename         = "lambda.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs8.10"
  handler          = "lambda_function.lambda_handler"
  timeout          = 10
  description      = "Managed by Terraform. For Assignment 3.7"
}
