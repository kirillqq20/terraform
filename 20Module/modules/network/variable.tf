variable "vpc_cidr" {
  default = "172.31.0.0/16"
}
variable "env" {
  default = "prod"
}
variable "public_subnet_cidrs" {
  default = [
      "172.31.1.0/24",
      "172.31.2.0/24"
  ] 
  }
  variable "private_subnet_cidrs" {
    default = [
        "172.31.11.0/24",
        "172.31.22.0/24"
    ]
  }