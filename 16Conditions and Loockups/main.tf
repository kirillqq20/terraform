provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = var.env == "prod" ? "t2.micro" : "t2.large"
  // instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"] 

  tags = {
    Name  = "${var.env} - server"
    Owner = "var.owner"
  }
}

resource "aws_instance" "dev-web-server" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = "t2.micro"

  tags = {
    Name = "Dev_Web_Server"
  }

}

resource "aws_instance" "lookup_serv" {
  count         = 1
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name = "${var.env} - serv"
  }
}
resource "aws_security_group" "web_serv_secur" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = lookup(var.ports_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
}
  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name  = "Dynamic Security Group"
    Owner = "Ivan Ivanov"
  }


}
