terraform {
  backend "s3" {
    bucket = "ayush-terraform-states"
    key    = "static-website/hosting"
    region = "ap-southeast-1"
  }
}
