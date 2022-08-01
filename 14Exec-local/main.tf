provider "aws" {
  region     = "eu-central-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START : $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "echo $name1 $name2 $name3 >> names.txt"
    environment = {
      name1 = "Egor"
      name2 = "Anton"
      name3 = "Kirill"
    }
  }
}

resource "aws_instance" "testserv" {
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo AWS Instance Creation!"
    
  }
  tags = {
      "Name" = "AWS-serv"
    }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command = "echo Terraform END : $(date) >> log.txt"
  }
  depends_on = [
    null_resource.command1, null_resource.command2, aws_instance.testserv
  ]
}
