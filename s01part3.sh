sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo 'LogFormat "%h %l %u %t \"%r\" %>s %b" combined' >> /etc/httpd/conf/httpd.conf
sudo echo 'CustomLog "|/usr/bin/logger -t httpd -p local5.info" combined' >> /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
echo "local5.*    /var/log/web.log" | sudo tee -a /etc/rsyslog.conf
sudo systemctl restart rsyslog
curl http://localhost
authpriv.*    @@10.1.1.20:514
sudo systemctl restart rsyslog
echo 'module(load="imudp")' | sudo tee -a /etc/rsyslog.conf > /dev/null
echo 'input(type="imudp" port="514")' | sudo tee -a /etc/rsyslog.conf > /dev/null
echo 'module(load="imtcp")' | sudo tee -a /etc/rsyslog.conf > /dev/null
echo 'input(type="imtcp" port="514")' | sudo tee -a /etc/rsyslog.conf > /dev/null
sudo systemctl restart rsyslog
curl http://localhost
