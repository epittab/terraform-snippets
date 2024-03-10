output "domain" {
  value = aws_s3_bucket_website_configuration.ui.website_endpoint
}

output "cognito" {
  value = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${var.aws_region}.amazoncognito.com/login?response_type=code&client_id=${aws_cognito_user_pool_client.userpool_client.id}&redirect_uri=${var.callback_url}"
}