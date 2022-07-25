provider "aws" {
  
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

output "latest_ubuntu_ami_id" {
    value = data.aws_ami.latest_ubuntu.id  
}

output "latest_ubuntu_ami_name" {
    value = data.aws_ami.latest_ubuntu.name  
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }
}

output "latest_amazon_linux_ami_id" {
    value = data.aws_ami.latest_amazon_linux.id  
}

output "latest_amazon_linux_ami_name" {
    value = data.aws_ami.latest_amazon_linux.name  
}