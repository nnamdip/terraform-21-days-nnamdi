resource "aws_security_group" "public" {
    name = "public"
    description = "allow public cnnection"
    vpc_id = aws_vpc.example_vpc.id


    ingress {
    description      = "ssh from office"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = []
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main"
  }
}

resource "aws_instance" "public" {
  
  ami                    = "ami-022e1a32d3f742bd8"
  instance_type          = "t2.micro"
  #subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.public.id]
  key_name = "demo"
  associate_public_ip_address = true

  tags = {
    Name = "public"
  }
 
}

output "public_ip_address" {
    value = aws_instance.public.private_ip
  
}