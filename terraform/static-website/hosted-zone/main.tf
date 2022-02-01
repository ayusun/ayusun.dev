resource "aws_route53_zone" "hosted_zone" {
  name = local.hosted_zone
}