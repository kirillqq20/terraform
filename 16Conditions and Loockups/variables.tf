variable "env" {
  default = "prod"
}
variable "owner" {
  default = "Ivan Ivanov"
}
variable "ec2_size" {
  default = {
    "staging" = "t2.micro"
    "prod"    = "t2.small"
    "dev"     = "t2.large"
  }
}
variable "ports_list" {
  default = {
    "prod"    = ["80", "443"]
    "dev"     = ["80", "443", "22"]
    "staging" = ["80", "8080"]
  }
}
