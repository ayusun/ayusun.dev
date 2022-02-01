terraform {
  backend "s3" {
    bucket = "ayush-terraform-states"
    key    = "static-website/hosted-zone"
    region = "ap-southeast-1"
  }
}
