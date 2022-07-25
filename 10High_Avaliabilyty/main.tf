provider "aws" {
  
}

data "aws_availability_zones" "avaliability" {}
data "aws_ami" "ubuntu_latest" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_security_group" "avaliability_ubuntu_latest" {
  name        = "WebServer Avaliability Security Group"
  description = "Avaliability SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
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
resource "aws_eip" "My_static_ip" {}

resource "aws_launch_configuration" "web" {
  name_prefix     = "WebServer-Highly-Avaliability -- "
  image_id        = data.aws_ami.ubuntu_latest.id
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.avaliability_ubuntu_latest.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {

  name_prefix          = "WebServer-Highly-Avaliability-ASG --"
  launch_configuration = aws_launch_configuration.web.name
  min_size             = 2
  max_size             = 2
  min_elb_capacity     = 2
  vpc_zone_identifier  = [aws_default_subnet.defualt_subnet.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.web.name]

  dynamic "tag" {
    for_each = {
      Name  = "ASG-server"
      Owner = "Petr Petrov"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }

  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "web" {
  name               = "web-server-ELB"
  availability_zones = [data.aws_availability_zones.avaliability.names[0]]
  security_groups    = [aws_security_group.avaliability_ubuntu_latest.id]
  listener {
    lb_port           = "80"
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    "Name" = "Web-server-ASG-ELB"
  }
}
resource "aws_default_subnet" "defualt_subnet" {
  availability_zone = data.aws_availability_zones.avaliability.names[0]
}
