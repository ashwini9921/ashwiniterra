terraform {
  required_version = "~>1.12.0"
  required_providers {
    aws = {
        version = "~>6.0"
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "testlab" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "testlab"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.testlab.id
  cidr_block = "192.168.1.0/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "testlab_private"
  }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.testlab.id
  cidr_block = "192.168.1.64/26"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "testlab_public"
  }
}