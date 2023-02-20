terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

provider "aws" {
    profile = "default"
    region = "eu-west-2"
  
}
resource "aws_vpc" "my_vpc-1" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "First_vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my_vpc-1.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  

  tags = {
    Name = "First-subnet"
  }
}
resource "aws_instance" "EC2-1" {
  subnet_id     = aws_subnet.subnet-1.id 
  ami           = "ami-09ee0944866c73f62" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = true
 
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc-1.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_security_group" "SGS" {
  name        = "allow_SSH"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.my_vpc-1.id

  ingress {
    description      = "SSH into Instance"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH connection"
  }
}
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.SGS.id
  network_interface_id = aws_instance.EC2-1.primary_network_interface_id
}

resource "aws_route" "route" {
  route_table_id = aws_vpc.my_vpc-1.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
