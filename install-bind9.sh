echo -e "\n--- installing DNS/Bind9 ---\n"
sudo apt-get -qq update
sudo apt-get install -y bind9 > /dev/null 2>&1
echo -e "\n--- Configure Bind9 for show ---\n"
su root
vagrant
sudo mkdir /etc/bind/zones
sudo cat > /etc/bind/zones/demo.com.db << "EOF"
$TTL 3D
@ IN SOA server.demo.com. admin.demo.com. (
2007031001
28800;
3600;
604800;
38400
);

demo.com.   IN      NS      server.demo.local.
demo.com.   IN      MX      0       mail.demo.com.
demoserver       IN      A       172.16.0.5
www             IN      A       172.16.0.5
mail            IN      A       172.16.0.5
vm1  IN      A       172.16.0.101
EOF

sudo cat > /etc/bind/zones/googleapis.com.db << "EOF"
$TTL 3D
@ IN SOA demo.googleapis.com. admin.googleapis.com. (
2007031001
28800;
3600;
604800;
38400
);

googleapis.com. IN      NS      server.demo.local.
www             IN      A       172.16.0.5
googleapis.com. IN      A       172.16.0.5
EOF
sudo rm -r -f /etc/bind/named.conf.local
sudo cat > /etc/bind/named.conf.local << "EOF"
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

#forward lookups

zone "demo.com"
{
        type master;
        file "/etc/bind/zones/demo.com.db";
};
zone "googleapis.com"
{
        type master;
        file "/etc/bind/zones/googleapis.com.db";
};
EOF

sudo service bind9 restart


echo -e "\n--- Staring bind9 ---\n"
