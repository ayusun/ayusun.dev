resource "aws_api_gateway_rest_api" "ContactAPI" {
  name        = "AyusunContactAPI"
  description = "This is API for Contact form"
}

resource "aws_api_gateway_resource" "ContactResource" {
  rest_api_id = aws_api_gateway_rest_api.ContactAPI.id
  parent_id   = aws_api_gateway_rest_api.ContactAPI.root_resource_id
  path_part   = local.api_gw_path
}

resource "aws_api_gateway_method" "ContactMethod" {
  rest_api_id   = aws_api_gateway_rest_api.ContactAPI.id
  resource_id   = aws_api_gateway_resource.ContactResource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ContactFormIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.ContactAPI.id
  resource_id          = aws_api_gateway_resource.ContactResource.id
  http_method          = aws_api_gateway_method.ContactMethod.http_method
  type                 = "AWS_PROXY"
  integration_http_method = "POST"
  uri                  = aws_lambda_function.lambda.invoke_arn
#  cache_key_parameters = ["method.request.path.param"]
  cache_namespace      = "foobar"
  timeout_milliseconds = 29000

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}

## Deployment of Gateway
resource "aws_api_gateway_deployment" "ContactFormDeployment" {
  rest_api_id = aws_api_gateway_rest_api.ContactAPI.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.ContactAPI.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "contact_prod_stage" {
  deployment_id = aws_api_gateway_deployment.ContactFormDeployment.id
  rest_api_id   = aws_api_gateway_rest_api.ContactAPI.id
  stage_name    = local.api_gw_stage_name
}