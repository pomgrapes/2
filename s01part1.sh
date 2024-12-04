sudo yum install -y nfs-utils
sudo yum install -y httpd
sudo yum install -y net-tools
echo -e "\n10.1.1.30\ts02" >> /etc/hosts
tar -cvf /tmp/etc.tar /etc
find /opt/Mohawk/books -print | cpio -ov > /tmp/books.cpio
tar -cvf /tmp/foo.tar /opt/Mohawk/data/4_f.green /opt/Mohawk/books/ShelockHolmes.txt
mkdir -p /nfs/s02
sudo groupadd s02user
sudo useradd -g s02user s02user
sudo chown -R s02user:s02user /nfs/s02
chmod 775 /nfs/s02
systemctl enable --now nfs-server
firewall-cmd --permanent --add-service=nfs
firewall-cmd --permanent --add-service=rpc-bind
firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --permanent --add-port=514/tcp
sudo firewall-cmd --permanent --add-port=514/udp
firewall-cmd --reload
echo "/nfs/s02 10.1.1.30(rw,sync,no_root_squash)" >> /etc/exports
exportfs -ra
