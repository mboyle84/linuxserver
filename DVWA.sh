cd /var/www
sudo mkdir demo
cd /var/www/demo
echo -e "\n--- creating a DVWA on LAP Server ---\n"
apt-get -qq update
apt-get -y install unzip > /dev/null 2>&1
wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.zip  > /dev/null 2>&1
