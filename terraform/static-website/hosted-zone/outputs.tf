output "zone_id" {
    value = aws_route53_zone.hosted_zone.zone_id
    description = "Outputs hosted zone id"
}