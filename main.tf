resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired VPC CIDR block

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.1.0/24"  # Replace with your desired public subnet CIDR block
  availability_zone       = "us-east-1a"  # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.2.0/24"  # Replace with your desired public subnet CIDR block
  availability_zone       = "us-east-1b"  # Replace with your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.3.0/24"  # Replace with your desired private subnet CIDR block
  availability_zone       = "us-east-1a"  # Replace with your desired availability zone

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.4.0/24"  # Replace with your desired private subnet CIDR block
  availability_zone       = "us-east-1b"  # Replace with your desired availability zone

  tags = {
    Name = "private-subnet-2"
  }
}
In this example, a VPC is created with the CIDR block 10.0.0.0/16. Two public subnets are created with CIDR blocks 10.0.1.0/24 and 10.0.2.0/24, respectively. Two private subnets are also created with CIDR blocks 10.0.3.0/24 and 10.0.4.0/24, respectively. You can modify the CIDR blocks and other parameters as per your requirements.

Remember to replace the desired AWS region, CIDR blocks, and availability zones with your own preferences.





User
please i dont want to repeat code 
ChatGPT
Apologies for the repetition. To avoid duplicating code, you can utilize a loop and a list of subnet configurations. Here's an updated version of the Terraform code that uses a module and variables to create the VPC with multiple subnets:

Create a file named vpc_subnets.tf with the following code:

hcl
Copy code
provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = var.num_public_subnets
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = var.num_private_subnets
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
Next, create a file named variables.tf to define the variables used in the module:

hcl
Copy code
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "num_public_subnets" {
  description = "Number of public subnets to create"
  type        = number
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "num_private_subnets" {
  description = "Number of private subnets to create"
  type        = number
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}