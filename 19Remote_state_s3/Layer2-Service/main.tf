provider "aws" {

  region     = "eu-central-1"
}

terraform {
  backend "s3" {

    bucket     = "terraform-test-kir"
    key        = "dev/servers/terraform.tfstate"
    region     = "eu-central-1"
  }
}

data "aws_ami" "amazon_linux_latest" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }
}

resource "aws_instance" "amazon-linux" {
  ami                    = data.aws_ami.amazon_linux_latest.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.test_security_group.id]
  subnet_id              = data.terraform_remote_state.network.outputs.subnet_id[0]
  user_data              = file("user_data.sh")

  tags = {
    Name  = "WebServer"
    Owner = "Ivan Ivanov"
  }
}

data "terraform_remote_state" "network" {

  backend = "s3"
  config = {

    bucket     = "terraform-test-kir"
    key        = "dev/network/terraform.tfstate"
    region     = "eu-central-1"
  }
}

resource "aws_security_group" "test_security_group" {
  name   = "WebServer test security group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "test-server-sec"
    Owner = "Ivan Ivanov"
  }
}


