variable "vpc_cidr" {
  default = "172.0.0.0/16	"
}
variable "env" {
  default = "dev"
}
variable "public_subnet_sider" {
  default = [
    "172.31.0.0/24",
    "172.16.0.0/24"
  ]
}