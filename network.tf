resource "aws_vpc" "epb_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "epb-vpc"
  }
}

resource "aws_subnet" "epb-subnet" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.epb_vpc.id
  availability_zone = var.aws_region_az

  tags = {
    Name = "epb-subnet"
  }
}

resource "aws_security_group" "epb-sg" {
  name_prefix = "epb-sg"
  vpc_id      = aws_vpc.epb_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}