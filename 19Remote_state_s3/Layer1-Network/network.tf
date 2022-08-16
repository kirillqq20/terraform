provider "aws" {

  region     = "eu-central-1"
}


terraform {
  backend "s3" {

    bucket     = "terraform-test-kir"
    key        = "dev/network/terraform.tfstate"
    region     = "eu-central-1"
  }
}

data "aws_availability_zones" "avaliability" {}


resource "aws_subnet" "subnets" {
  count                   = length(var.public_subnet_sider)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_sider, count.index)
  availability_zone       = data.aws_availability_zones.avaliability.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public -${count.index} + 1"
  }
}

resource "aws_route_table" "public_subnet" {

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = aws_internet_gateway.vpc.id
  }
  tags = {
    Name = "${var.env}-route-public-subnet"
  }
}

resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.subnets[*].id)
  route_table_id = aws_route_table.public_subnet.id
  subnet_id      = element(aws_subnet.subnets[*].id, count.index)
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env} - vpc"
  }
}

resource "aws_internet_gateway" "vpc" {

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env} - igw"
  }
}

