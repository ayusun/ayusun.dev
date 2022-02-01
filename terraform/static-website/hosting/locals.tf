locals {
  root_domain           = "ayusun.dev"
  www_domain            = "www.${local.root_domain}"
  san_certs_domain      = [local.www_domain]
  contact_form_api_uri  = data.terraform_remote_state.contact_form_api.outputs.gw_invoke_url
  contact_form_domain   = replace(trimprefix(local.contact_form_api_uri, "https://"), "/${data.terraform_remote_state.contact_form_api.outputs.gw_stage_name}", "")
  contact_form_api_path = "/${data.terraform_remote_state.contact_form_api.outputs.gw_stage_name}/${data.terraform_remote_state.contact_form_api.outputs.gw_path}"
}