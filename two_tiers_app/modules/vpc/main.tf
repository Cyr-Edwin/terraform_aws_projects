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
resource "aws_subnet" "pr-sub-rd1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public-cidr-block1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = var.pr-sub-rd1
  }
  depends_on = [ aws_subnet.web-subnet2 ]
}

 #Create private subnet for RDS-2
resource "aws_subnet" "pr-sub-rd2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public-cidr-block2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = var.pr-sub-rd2
  }
  depends_on = [ aws_subnet.pr-sub-rd1 ]
}

# Create Elastic IP for NAT Gateway 1
resource "aws_eip" "nat_gw_eip1" {
  domain = "vpc"
  tags = {
    Name= var.nat_gw_eip-1
  }
depends_on = [ aws_subnet.pr-sub-rd2 ]
  
}

# Create Elastic IP for NAT Gateway 2
resource "aws_eip" "nat_gw_eip2" {
  domain = "vpc"
  tags = {
    Name= var.nat_gw_eip-2
  }
depends_on = [ aws_eip.nat_gw_eip1 ]
  
}

# Create NAT Gateway 1
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_gw_eip1.id
  subnet_id = aws_subnet.web-subnet1.id
  tags = {
    Name = var.nat-1
  }
  depends_on = [ aws_eip.nat_gw_eip2 ]
}