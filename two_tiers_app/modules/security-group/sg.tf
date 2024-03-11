# create security group for alb
resource "aws_security_group" "alb-sg" {
  description = "Allow HTTP and HTTPS traffic for anyone  "
  vpc_id      = data.aws_vpc.vpc.id
   ingress {
    from_port = 440
    to_port = 440
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
   }
   ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
   }

   egress {
    from_port = 440
    to_port = 440
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
   }

  tags = {
    Name = var.alb-sg-name
  }
   depends_on = [ var.vpc-name ]
}

