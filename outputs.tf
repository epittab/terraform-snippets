output "domain" {
  value = aws_s3_bucket_website_configuration.ui.website_endpoint
}

output "cognito_endpoint" {
  value = aws_cognito_user_pool.pool.endpoint
}