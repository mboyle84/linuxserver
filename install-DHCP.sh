echo -e "\n--- install DHCP Service ---\n"
sudo apt-get -qq update
sudo apt-get install isc-dhcp-server -y > /dev/null 2>&1
echo -e "\n--- Setting up server to servce out IP address to users/devices ---\n"
sudo cat > /etc/default/isc-dhcp-server << "EOF"
INTERFACES="eth0"
EOF
sudo cat > /etc/dhcp/dhcpd.conf << "EOF"
ddns-update-style none;

# option definitions common to all supported networks...
option domain-name-servers 172.16.0.5;
default-lease-time 600;
max-lease-time 7200;
log-facility local7;
authoritative;
subnet 172.16.0.0 netmask 255.255.255.0 {
 range 172.16.0.102 172.16.0.200;
 option domain-name-servers 172.16.0.5;
 option routers 172.16.0.1;
 option broadcast-address 172.16.0.255;
 default-lease-time 600;
 max-lease-time 7200;
 }
EOF

echo -e "\n--- DHCP configured!! DO NOT RUN THIS VM ON OUR COPORATE OR ANY OTHER NETWORK!!!!! ---\n"
echo -e "\n---  WARNING, will interfear with networking!!! to start run command: sudo service isc-dhcp-server start or start vm after script completion  ---\n"