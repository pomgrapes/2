echo -e "\n10.1.1.30\ts02" >> /etc/hosts
yum install -y nfs-utils
sudo yum install -y httpd
sudo yum install -y net-tools
netstat -a | grep 'nfs.*10.1.1.20'
systemctl enable --now nfs-server
sudo mkdir -p /mnt
sudo mount -t nfs 10.1.1.20:/nfs/s02 /mnt
nmcli connection modify enp0s3 ipv4.addresses 10.1.1.30/24
nmcli connection modify enp0s3 ipv4.method manual
nmcli connection modify enp0s3 ipv6.method disable
nmcli connection up enp0s3
sudo hostnamectl set-hostname s02
echo "10.1.1.20:/nfs/s02 /mnt nfs defaults 0 0" >> /etc/fstab
sudo mkdir -p /nfs/s02
sudo mount -t nfs 10.1.1.20:/nfs/s02 /nfs/s02

echo "This is a test file" | sudo tee /nfs/s02/testfile.txt
sudo chmod 644 /nfs/s02/testfile.txt
echo "authpriv.*    @@10.1.1.20:514" | sudo tee -a /etc/rsyslog.conf /dev/nul
sudo systemctl restart rsyslog
