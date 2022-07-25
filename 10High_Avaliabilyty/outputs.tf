output "load_balanser_url" {
  value = aws_elb.web.dns_name  
}
output "webserver_instance_id" {
  value =  aws_launch_configuration.web.id
}
output "webserver_public_adress" {
  value =  aws_eip.My_static_ip.public_ip
}
output "SecurityGroup" {
  value =  aws_security_group.avaliability_ubuntu_latest.id
}
