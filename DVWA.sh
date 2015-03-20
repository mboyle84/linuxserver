DBPASSWD=vagrant
DBNAME=dvwa
DBUSER=dvwa
DBdvwaPWD=p@ssw0rd

cd /var/www
sudo mkdir demo.com
cd /var/www/demo.com
echo -e "\n--- Setting up a DVWA on the LAMP Server base. This will take sometime ---\n"
apt-get -qq update
apt-get -y install unzip > /dev/null 2>&1
wget https://github.com/RandomStorm/DVWA/archive/v1.0.8.zip  > /dev/null 2>&1
sudo unzip v1.0.8.zip > /dev/null 2>&1
sudo mv /var/www/demo.com/DVWA-1.0.8/ /var/www/
sudo rm -r /var/www/demo.com/
sudo mv /var/www/DVWA-1.0.8/ /var/www/demo.com/
cd /var/www/demo.com
sudo find . -type f -exec chmod 655 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo chown -R www-data:www-data /var/www/demo.com/

echo -e "\n--- DVWA is setup on port 80, configuring DVWA for enviroment ---\n"
echo -e "\n--- Setting up dvwa db and users ---\n"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME;"
#mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBdvwaPWD';"
#mysql -uroot -p$DBPASSWD -e "FLUSH PRIVILEGES;"


sudo cat > /var/www/demo.com/config/config.inc.php << "EOF"
<?php

# If you are having problems connecting to the MySQL database and all of the variables below are correct
# try changing the 'db_server' variable from localhost to 127.0.0.1. Fixes a problem due to sockets.
# Thanks to digininja for the fix.

# Database management system to use

$DBMS = 'MySQL';
#$DBMS = 'PGSQL';

# Database variables
# WARNING: The database specified under db_database WILL BE ENTIRELY DELETED during setup.
# Please use a database dedicated to DVWA.

$_DVWA = array();
$_DVWA[ 'db_server' ] = 'localhost';
$_DVWA[ 'db_database' ] = 'dvwa';
$_DVWA[ 'db_user' ] = 'root';
$_DVWA[ 'db_password' ] = 'vagrant';

# Only needed for PGSQL
#$_DVWA[ 'db_port' ] = '5432';

# ReCAPTCHA Settings
# Get your keys at https://www.google.com/recaptcha/admin/create
#$_DVWA['recaptcha_public_key'] = "";
#$_DVWA['recaptcha_private_key'] = "";

# Default Security Level
# The default is high, you may wish to set this to either low or medium.
# If you specify an invalid level, DVWA will default to high.
$_DVWA['default_security_level'] = "high";

?>

EOF
echo -e "\n--- connect to http://127.0.0.1/setup.php and run command to create db, curl auto create appears not to work  ---\n"
#curl --data ‘create db=create+%2F+Reset+Database’ http://127.0.0.1/setup.php# --cookie PHPSESSID=1  > /dev/null 2>&1
sudo service apache2 restart
