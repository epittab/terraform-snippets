data "archive_file" "init" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "lambda"
    filename = "init.txt"
  }
}

resource "aws_lambda_function" "epb_test_lambda" {
  filename      = data.archive_file.init.output_path
  function_name = "epb_lambda_name"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs20.x"
  handler       = "index.handler"
}