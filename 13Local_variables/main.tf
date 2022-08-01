provider "aws" {
  region     = var.region
}

locals {
  full_name_project = "${var.owner} - ${var.enviroment}"
  all_information   = "${var.owner} - ${var.enviroment} - ${var.region} "
}
resource "aws_eip" "MyIP" {
  tags = {
    Name    = "MyIP"
    Owner   = var.owner
    Project = local.full_name_project
    Info = local.all_information
  }

}
