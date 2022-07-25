provider "aws" {
  
}

resource "aws_instance" "ubuntu_web_server" {
  ami                    = "ami-0a1ee2fb28fe05df3"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ubuntu_web_server.id]
  user_data              = <<EOF
#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
echo "<html><head><title>testing terraform</title></head><body><?php echo '<p>Great work!</p>' ?></body></html>">> /var/www/html/index.html
sudo service httpd restart
chkconfig httpd on
EOF
  tags = {
    Name    = "Ubuntu server for Terraform"
    Owner   = "Petr Petrov"
    Project = "Terraform test"

  }
}
resource "aws_security_group" "ubuntu_web_server" {
  name        = "WebServer Security Group"
  description = "First SecurityGroup"

  ingress {
    description = "First SecurityGroup"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "First SecurityGroup"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_server"
  }
}
