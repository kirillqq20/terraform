provider "aws" {
  
}

resource "aws_instance" "my_Ubuntu" {
  ami           = "ami-065deacbcaac64cf2"
  instance_type = "t3.micro"
  tags = {
    Name    = "Ubuntu server for Terraform"
    Owner   = "Petr Petrov"
    Project = "Terraform test"
  }

}
