provider "aws" {

  region     = "eu-central-1"
}
provider "aws" {

  region     = "us-east-1"
  alias      = "USA"
}

data "aws_ami" "server_usa" {
  provider    = aws.USA
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "server_europ" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }

}

resource "aws_instance" "default" {
  count         = 1
  ami           = data.aws_ami.server_europ.id
  instance_type = "t2.micro"

  tags = {
    Name = "Default AmazonLinux server"
  }
}
resource "aws_instance" "default_server_in_usa" {
  provider      = aws.USA
  count         = 1
  ami           = data.aws_ami.server_usa.id
  instance_type = "t2.micro"

  tags = {
    Name = "Default Ubuntu server in USA"
  }
}
