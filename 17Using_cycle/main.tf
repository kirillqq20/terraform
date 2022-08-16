provider "aws" {
  region     = "eu-central-1"
}

resource "aws_iam_user" "create-users" { // create user using list variables
  count = length(var.users_list)
  name  = element(var.users_list, count.index)
}

output "users-list-created" { // output list
  value = aws_iam_user.create-users
}
output "created-users-id" { // output all user id
  value = aws_iam_user.create-users[*].id
}

output "created-users-custom" { // output in cycle for user.name and user.arn
  value = [
    for usr in aws_iam_user.create-users :
    "Username: ${usr.name} has ARN: ${usr.arn}"
  ]
}

output "created_iam_users_map" { // output in map and using cycle for 
  value = {
    for usr in aws_iam_user.create-users :
    usr.unique_id => usr.id //"AIDA4AWS2BAHVW3ZTGRTH" : "id"

  }
}

output "created_iam_if" { // output where using if lenght
  value = [
    for usr in aws_iam_user.create-users :
    usr.name
    if length(usr.name) == 4
  ]
}

resource "aws_instance" "create-servers" {
  count         = 2
  ami           = "ami-0a1ee2fb28fe05df3"
  instance_type = "t2.micro"

  tags = {
    Name = "Server number - ${count.index + 1}"
  }
}

output "server_map" {
  value = {
    for serv in aws_instance.create-servers :
    serv.id => serv.public_ip
  }
}
