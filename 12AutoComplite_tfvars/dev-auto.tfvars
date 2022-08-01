region        = "eu-central-1"
instance_type = "t3.micro"
list_ports    = ["80", "443", "8080"]

common_tags = {
  Owner      = "Petr Petrov"
  Project    = "Linux project"
  Enviroment = "Prod"
}
