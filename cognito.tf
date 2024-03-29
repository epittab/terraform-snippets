resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "example-domain-${random_string.suffix.result}"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  name                                 = "client"
  user_pool_id                         = aws_cognito_user_pool.pool.id
  callback_urls                        = [var.callback_url]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid"]
  supported_identity_providers         = ["COGNITO"]
  access_token_validity                = 2
  id_token_validity                    = 2
  refresh_token_validity               = 1
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}


resource "aws_cognito_user_pool" "pool" {
  name = "my-test-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]


  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
}



