terraform {
  backend "s3" {
    bucket = "ayush-terraform-states"
    key    = "static-website/contact-form"
    region = "ap-southeast-1"
  }
}
