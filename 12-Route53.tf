data "aws_route53_zone" "mfnerd" {
  name         = "mfnerd.org"  # The domain name you want to look up
  private_zone = false
  
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.mfnerd.zone_id
  name    = "mfnerd.org"
  type    = "A"
  alias {
    name                   = aws_lb.app1_alb.dns_name
    zone_id                = aws_lb.app1_alb.zone_id
    evaluate_target_health = true
  }
}