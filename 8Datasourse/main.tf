provider "aws" {
  
}
 
data "aws_availability_zones" "working" {}                
data "aws_caller_identity" "current" {}                   
data "aws_region" "region" {}                             
data "aws_vpcs" "myvps" {}                                
data "aws_vpc" "MyVPC" {                                  
    tags = {
        Name = "MyVPC"
    }
  }

resource "aws_subnet" "test_test" {                       # Create new subnet in VPC - MyVPC
vpc_id = data.aws_vpc.MyVPC.id
availability_zone = data.aws_availability_zones.working.names[0]
cidr_block = "10.0.1.0/24"
tags = {
  Name = "Subnet-1 in ${data.aws_availability_zones.working.names[0]}"
  Account = "Subnet in ${data.aws_caller_identity.current.account_id}"
  Region = data.aws_region.region.name
  }
}
  

output "aws_vpc_id" {
  value = data.aws_vpc.MyVPC.id

}

output "aws_vpc_cidr" {
  value = data.aws_vpc.MyVPC.cidr_block
  
}

output "aws_vpcs" {
  value = data.aws_vpcs.myvps.ids
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
  value = data.aws_region.region.name
}

