provider "aws" {

  region     = "eu-central-1"
}
terraform {
  backend "s3" {

    bucket     = "kir-kir-test-globalvars"
    key        = "globalvars/terraform.tfstate"
    region     = "eu-central-1"
  }
}

output "information" {
  value = "This information is secret"
}
output "owner" {
  value = "Ivan Ivan"
}
output "tags" {
  value = {
    Project = "Test"
    Country = "Ukraine"
  }
}
