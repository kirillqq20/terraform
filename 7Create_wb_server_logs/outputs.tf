output "webserver_instance_id" {
  value =  aws_instance.ubuntu_web_server.id
}
output "webserver_public_adress" {
  value =  aws_eip.My_static_ip.public_ip
}
output "SecurityGroup" {
  value =  aws_security_group.ubuntu_web_server.id
}