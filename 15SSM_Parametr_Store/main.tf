provider "aws" {
  region     = "eu-central-1"
}

variable "name" {
  default = "petr"
}
resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$&"
 // keepers = {                    используется для замены пароля с условием если изменится kepeer1 - var.name
 //   kepeer1 = var.name
 // }
}

resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "Master password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
}


data "aws_ssm_parameter" "password" {
  name = "/prod/mysql"
  depends_on = [
    aws_ssm_parameter.rds_password
  ]
}


resource "aws_db_instance" "MySqlServer" {
  identifier           = "prod-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class        = "db.t2.micro"
  name                 = "prod"
  username             = "administrator"
  password             = data.aws_ssm_parameter.password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}

output "rds_password" {
  value     = data.aws_ssm_parameter.password.value
  sensitive = true
}