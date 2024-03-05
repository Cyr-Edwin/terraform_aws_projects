provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  
}

# create Security Group for EC2 and ALB
resource "aws_security_group" "sg" {
  name        = "security group"
  description = "Allow incoming HTTP Connections"

ingress{
    from_port = 80
    to_port= 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress{
    from_port = 0
    to_port= 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

  tags = {
    Name = "allow_tls"
  }
}

data "aws_vpc" "default"{
    default = true
}

data "aws_subnet" "sub1" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}

data "aws_subnet" "sub2" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1b"
}
# create EC2 instance
resource "aws_instance" "ec2" {
    ami = "ami-0440d3b780d96b29d"
    instance_type = "t2.micro"
    key_name = "whizlabs-key"
    count = 2
    security_groups = [ "${aws_security_group.sg.name}" ]
    user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    sudo chmod 777 /var/www/html
    echo "<html><h1>Hello World from$(hostname -f)...</h1></html>" >> /var/www/html/index.html
    EOF

    tags = {
      Name = "instance${count.index}"
    }
  
}

# create Target Group
resource "aws_lb_target_group" "target-gp" {
  health_check {
    interval = 10
    path ="/"
    protocol ="HTTP"
    timeout = 5
    healthy_threshold =5
    unhealthy_threshold=2
}
 name     = "target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = data.aws_vpc.default.id
  
}

# create Application  Load Balancer
resource "aws_lb" "alb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [data.aws_subnet.sub1.id ,  data.aws_subnet.sub2.id]

  tags = {
    Name= "applicatiom load balancer"
  }
}

# create the Listener
resource "aws_lb_listener" "front_end1" {
load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-gp.arn
  }
}

# attaching Target Group to ALB
resource "aws_lb_target_group_attachment" "test1" {
  count = length(aws_instance.ec2)
  target_group_arn = aws_lb_target_group.target-gp.arn
  target_id        = aws_instance.ec2[count.index].id
 
}
