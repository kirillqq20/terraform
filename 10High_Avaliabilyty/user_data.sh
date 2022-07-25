#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install nginx
myip=`sudo curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<html><head><title>testing terraform</title></head><body><h1>Great work Kirill17!</h1><br><p1>WebServer IP : $myip</p1><br><p2>Version 2</p2></body></html>">/var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx