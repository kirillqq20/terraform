provider "aws" {
  region     = var.region
}

data "aws_ami" "amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }
}

resource "aws_eip" "static_ip" {
  instance = aws_instance.amazon_linux.id
  tags = merge(var.common_tags, {
    Name    = "${var.common_tags["Enviroment"]} Server IP"
  })
}

resource "aws_instance" "amazon_linux" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  user_data              = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.linux_security.id]
  
  tags = merge(var.common_tags,{
    Name    = "${var.common_tags["Enviroment"]} Amazon Linux Server"
  })
}

resource "aws_security_group" "linux_security" {
  name = "Amazon Linux Security group"

  dynamic "ingress" {
    for_each = var.list_ports
    content {
      from_port  = ingress.value
      to_port    = ingress.value
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags,{
      Name    = "${var.common_tags["Enviroment"]} Amazon Linux Security group"
      })
}

