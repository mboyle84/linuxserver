cd /var/www
sudo mkdir demo.com
cd /var/www/demo.com
echo -e "\n--- creating a DVWA on LAP Server ---\n"
apt-get -qq update
apt-get -y install unzip > /dev/null 2>&1
wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.zip  > /dev/null 2>&1
sudo unzip v1.0.8.zip > /dev/null 2>&1
sudo mv /var/www/demo.com/DVWA-1.0.8/ /var/www/
sudo rm -r /var/www/demo.com/
sudo mv /var/www/DVWA-1.0.8/ /var/www/demo/
cd /var/www/demo.com
sudo find . -type f -exec chmod 655 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo chown -R www-data:www-data /var/www/demo.com/
sudo service apache2 restart
echo -e "\n--- DVWA setup and ready to be configured hit local host on port 80 or redirect port for vagrantfile ---\n"

