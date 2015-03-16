echo -e "\n--- Configuring network ip and shutting down for network transfer ---\n"
sudo cat > /etc/network/interfaces << "EOF"
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
address 172.16.0.5
netmask 255.255.255.0
broadcast 172.16.0.255
gateway 172.16.0.1
dns-nameserver 172.16.0.5 
EOF



sudo init 0
