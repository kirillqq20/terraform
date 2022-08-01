region        = "eu-central-1"
instance_type = "t3.small"
list_ports    = ["80", "443"]

common_tags = {
  Owner      = "Ivan Ivanov"
  Project    = "Linux project"
  Enviroment = "Prod"
}
