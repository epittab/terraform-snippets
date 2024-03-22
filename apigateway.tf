resource "aws_api_gateway_rest_api" "test" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title       = "Hello World API"
      description = "This is a first attempt of setting up a rest api"
      version     = "1.0"
    }
    paths = {
      "/hello" = {
        get = {
          description = "First test path"
          responses = {
            "200" = {
              description = "Success"
            }
            "400" = {
              description = "Bad Request"
            }
          }
          x-amazon-apigateway-integration = {
            httpMethod = "POST"
            type       = "AWS_PROXY"
            uri        = aws_lambda_function.epb_test_lambda.invoke_arn
          }
        }
      }
    }
  })

  name = "Test Rest API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "test" {
  rest_api_id = aws_api_gateway_rest_api.test.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.test.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "test" {
  deployment_id = aws_api_gateway_deployment.test.id
  rest_api_id   = aws_api_gateway_rest_api.test.id
  stage_name    = "api"
}