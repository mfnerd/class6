# data "aws_route53_zone" "mfnerd" {
#   name         = "mfnerd.org"  # The domain name you want to look up
#   private_zone = false
#   
# }
# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.mfnerd.zone_id
#   name    = "mfnerd.org"
#   type    = "A"
#   ttl     = "300"
#   records = ["aws_lb.app1_alb.dns_name"]
#  
# }