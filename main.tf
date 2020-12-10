provider "aws" {
  region = "us-east-1"
  access_key = "AKIAJ24ZWPU5DYHZEWDA"
  secret_key = "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"
}

data "aws_ami" "ami-1" {
    owners = ["self"]
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["firstami"]
  }

}
resource "aws_instance" "instance-1" {
  ami           = data.aws_ami.ami-1.id
  instance_type = "t2.micro"

  tags = {
    Name = "secondinstance"
  }
}
resource "aws_vpc" "vpc-1" {
  cidr_block = "23.1.0.0/28"
  tags = {
    Name = "firstcreatedvpc"
  }
}
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "23.1.0.0/28"

  tags = {
    Name = "private"
  
}
}