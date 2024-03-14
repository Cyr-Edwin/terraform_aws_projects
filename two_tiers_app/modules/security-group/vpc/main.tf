# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

  tags = {
    Name = var.vpc-name
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = var.igw-name
    }
  depends_on = [ aws_vpc.vpc ]
}

# Create public subnet for web-1
resource "aws_subnet" "web-subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public-cidr-block1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name= var.web-public-subnet1
  }
  depends_on = [ aws_internet_gateway.igw ]
}

# Create public subnet for web-2
resource "aws_subnet" "web-subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public-cidr-block2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name= var.web-public-subnet2
  }
  depends_on = [ aws_subnet.web-subnet1 ]
}

# Create private subnet for RDS-1
