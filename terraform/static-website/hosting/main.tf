module "cloudfront_s3_website" {
  source                   = "github.com/ayusun/terraform-aws-cloudfront-s3-website-lambda-edge.git?ref=2.1.0"
  domain_name              = local.root_domain
  subject_alternative_name = local.san_certs_domain
  aws_region               = "us-east-1"
  tags = {
    ManagedBy = "Terraform"
    Service   = local.root_domain
  }
  ordered_cache_behaviour = [
    {
      allowed_methods          = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
      target_origin_id         = local.contact_form_domain
      path_pattern             = local.contact_form_api_path
      viewer_protocol_policy   = "https-only"
      cache_policy_id          = data.aws_cloudfront_cache_policy.managed_caching_disabled.id
      origin_request_policy_id = data.aws_cloudfront_origin_request_policy.managed_none.id
    }
  ]
  custom_origins = [{
    domain_name = local.contact_form_domain
    origin_id   = local.contact_form_domain
    origin_path = ""
  }]
}

resource "aws_route53_record" "www_record" {
  zone_id = data.terraform_remote_state.hosted_zone.outputs.zone_id
  name    = local.www_domain
  type    = "CNAME"
  ttl     = 60
  records = [local.root_domain]
}