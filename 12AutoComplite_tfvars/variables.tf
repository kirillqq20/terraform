variable "region" {
  default = "eu-central-1"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "list_ports" {
  default = ["80", "443"]
}
variable "common_tags" {
  default = {
    Owner   = "Petr Petrov"
    Project = "Linux project"
    Enviroment = "Development"
  }
}
