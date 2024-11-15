resource "aws_lb" "app1_alb" {
  name                       = "app1-load-balancer"
  internal                   = false
  load_balancer_type        = "application"
  security_groups           = [aws_security_group.app1-sg02-LB01.id]
  subnets                   = [
    aws_subnet.public-us-east-2a.id,
    aws_subnet.public-us-east-2b.id,
    aws_subnet.public-us-east-2c.id
  ]
  enable_deletion_protection = false
  
  # Add recommended settings
  drop_invalid_header_fields = true
  idle_timeout              = 60
  
  tags = {
    Name        = "App1LoadBalancer"
    Service     = "App1"
    Owner       = "User"
    Project     = "Web Service"
    Environment = "Production"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app1_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }
}

# resource "aws_lb" "app2_alb" {
#   name                       = "app2-load-balancer"
#   internal                   = false
#   load_balancer_type        = "application"
#   security_groups           = [aws_security_group.app2-sg02-LB02.id]
#   subnets                   = [
#     aws_subnet.public-us-east-2a.id,
#     aws_subnet.public-us-east-2b.id,
#     aws_subnet.public-us-east-2c.id
#   ]
#   enable_deletion_protection = false
  
#   # Add recommended settings
#   drop_invalid_header_fields = true
#   idle_timeout              = 60
  
#   tags = {
#     Name        = "App2LoadBalancer"
#     Service     = "App2"
#     Owner       = "User"
#     Project     = "Web Service"
#     Environment = "Production"
#   }
# }

data "aws_acm_certificate" "cert" {
  domain      = "mfnerd.org"
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app1_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01" # Updated to more secure policy
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }
}

output "lb_dns_name" {
  value       = aws_lb.app1_alb.dns_name
  description = "The DNS name of the App1 Load Balancer"
}

# output "lb2_dns_name" {
#   value       = aws_lb.app2_alb.dns_name
#   description = "The DNS name of the App2 Load Balancer"
# }
