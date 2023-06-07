provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_vpc" "nnamdi_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired VPC CIDR block

  tags = {
    Name = "nnamdi-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.nnamdi_vpc.id
  cidr_block              = "10.0.1.0/24"  # Replace with your desired public subnet CIDR block
  availability_zone       = "us-east-1a"  # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.nnamdi_vpc.id
  cidr_block              = "10.0.2.0/24"  # Replace with your desired public subnet CIDR block
  availability_zone       = "us-east-1b"  # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.nnamdi_vpc.id
  cidr_block              = "10.0.3.0/24"  # Replace with your desired private subnet CIDR block
  availability_zone       = "us-east-1a"  # Replace with your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.nnamdi_vpc.id
  cidr_block              = "10.0.4.0/24"  # Replace with your desired private subnet CIDR block
  availability_zone       = "us-east-1b"  # Replace with your desired availability zone

  tags = {
    Name = "private-subnet-2"
  }
}
