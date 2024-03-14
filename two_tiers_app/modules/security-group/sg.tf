# Create security group for alb
resource "aws_security_group" "alb-sg" {
  description = "Allow HTTP and HTTPS traffic for anyone  "
  vpc_id      = data.aws_vpc.vpc.id
   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
   }
   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
   }

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
   }

  tags = {
    Name = var.alb-sg-name
  }
   depends_on = [ var.vpc-name ]
}

# Create security for the web
resource "aws_security_group" "web-sg" {
  description = "Allow traffic only from ALB"
  vpc_id      = data.aws_vpc.vpc.id  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_groups = [ aws_security_group.alb-sg.id ]
   }
   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_groups = [ aws_security_group.alb-sg.id ]
   }
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # Allow all protocols
    cidr_blocks = [ "0.0.0.0/0" ]
   }

  tags = {
    Name = var.ec2-web-sg-name
  }
   depends_on = [ var.vpc-name ]
}

# Create RDS security group
resource "aws_security_group" "rds_sg" {
  description = "Allow traffic only from ALB"
  vpc_id      = data.aws_vpc.vpc.id 

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_groups = [ aws_security_group.alb-sg.id ]
   }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # Allow all protocols
    cidr_blocks = [ "0.0.0.0/0" ]
   } 
  
}