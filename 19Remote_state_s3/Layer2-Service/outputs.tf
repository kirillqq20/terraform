output "webserv_security_group_id" {
  value = aws_security_group.test_security_group.id
}
output "web_server_public_ip" {
  value = aws_instance.amazon-linux.public_ip
}