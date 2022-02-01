output "gw_invoke_url" {
  value = aws_api_gateway_stage.contact_prod_stage.invoke_url
  description = "invoke URL of API Gateway"
}

output "gw_path" {
  value = local.api_gw_path
  description = "The  path part of the API Gateway"
}

output "gw_stage_name" {
  value = local.api_gw_stage_name
  description = "The stage name deployed"
}