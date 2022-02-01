data "terraform_remote_state" "hosted_zone" {
  backend = "s3"
  config = {
    bucket = "ayush-terraform-states"
    key    = "static-website/hosted-zone"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "contact_form_api" {
  backend = "s3"
  config = {
    bucket = "ayush-terraform-states"
    key    = "static-website/contact-form"
    region = "ap-southeast-1"
  }
}

data "aws_cloudfront_cache_policy" "managed_caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "managed_none" {
  name = "Managed-None"
}