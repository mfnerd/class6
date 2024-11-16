resource "aws_security_group" "app1-sg01-servers" {
  name        = "app1-sg01-servers"
  description = "app1-sg01-servers"
  vpc_id      = aws_vpc.multi-app1.id

ingress {
  description = "MyHomePage"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg01-servers"
    Service = "application1"
    Owner   = "MFNerd"
    Planet  = "Uranus"
  }

}





resource "aws_security_group" "app1-sg02-LB01" {
  name        = "app1-sg02-LB01"
  description = "app1-sg02-LB01"
  vpc_id      = aws_vpc.multi-app1.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "MySecureHomePage"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg02-LB01"
    Service = "application1"
    Owner   = "MFNerd"
    Planet  = "Uranus"
  }

}
resource "aws_security_group" "app2-sg02-servers" {
  name        = "app2-sg02-servers"
  description = "app2-sg02-servers"
  vpc_id      = aws_vpc.multi-app1.id

ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app2-sg02-servers"
    Service = "application2"
    Owner   = "MFNerd"
    Planet  = "Uranus"
  }

}
# #security group for https traffic
# resource "aws_security_group" "app1-sg02-LB02" {
#   name        = "app1-sg02-LB02"
#   description = "app1-sg02-LB02"
#   vpc_id      = aws_vpc.multi-app1.id

#   ingress {
#     description = "MyHomePage"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name    = "app1-sg02-LB02"
#     Service = "application2"
#     Owner   = "MFNerd"
#     Planet  = "Uranus"
#   }

# }
