# resource "aws_iam_role" "lambda_role" {
#   name = "epb-lambda-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       }
#     }]
#   })
# }

# resource "aws_iam_policy" "logging_policy" {
#   name = "logging_policy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Action = [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents"
#       ]
#       Resource = ["arn:aws:logs:*:*:*"]
#       }, {
#       Effect = "Allow"
#       Action = [
#         "ec2:CreateNetworkInterface",
#         "ec2:DescribeNetworkInterfaces",
#         "ec2:DeleteNetworkInterface"
#       ]
#       Resource = ["*"]
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "epb_lambda_privileges" {
#   policy_arn = aws_iam_policy.logging_policy.arn
#   role       = aws_iam_role.lambda_role.name
# }