provider "aws" {

  region     = "eu-central-1"
}

module "vpc-dev" {
  source = "../modules/network"
}

