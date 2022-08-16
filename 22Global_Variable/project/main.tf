provider "aws" {

  region     = "eu-central-1"
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {

    bucket     = "kir-kir-test-globalvars"
    key        = "globalvars/terraform.tfstate"
    region     = "eu-central-1"
  }
}

locals {
  information = data.terraform_remote_state.global.outputs.information
  owner       = data.terraform_remote_state.global.outputs.owner
  common_tags = data.terraform_remote_state.global.outputs.tags
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "172.31.0.0/16"
  tags = merge(local.common_tags, {
    Name  = "Test_VPC"
    Info  = local.information
    Owner = local.owner
  })
}
