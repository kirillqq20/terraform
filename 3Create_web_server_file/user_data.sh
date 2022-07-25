#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip=`sudo curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<html><head><title>testing terraform</title></head><body><h1>Great work!</h1><br><p1>WebServer IP : $myip</p1></body></html>"> /var/www/html/index.html
sudo service httpd restart
chkconfig httpd on