#setting up joomla or wordpress each are the same  variables for importing
APPENV=local
DBHOST=localhost
DBPASSWD=vagrant
DBNAME=vagrant_jmln1
DBUSER=vagrant_jmln1
DBJPWD=joomlapwd
FTPPWD=ftppassword
FTPusere=vagrant
RemoteSQL=x.x.x.x



echo -e "\n--- Setting up our Joomal/wordpress user and db for website replication ---\n"
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME;"
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBJPWD';"
mysql -uroot -p$DBPASSWD -e "FLUSH PRIVILEGES;"

echo -e "\n--- copying down mysql database from live site ---\n" 
mysqldump -P3306  -h$RemoteSQL -u$DBUSER -p$DBJPWD $DBNAME > ~/backup.sql

echo -e "\n--- importing database  ---\n" 
mysql -uroot -p$DBPASSWD $DBNAME < ~/backup.sql

echo -e "\n--- install lftp for file transfer ---\n"
sudo apt-get -y install lftp > /dev/null 2>&1

echo -e "\n--- ftping down files from live site, this will take awhile, check log file at /home/vagrant/webreplog for details  ---\n" 
cd /var/www/

lftp -e 'set ftp:ssl-allow no; mirror --verbose /public_html/demo.com /var/www/demo.com' -u vagrant,vagrant ftp://demo.com > /home/vagrant/webreplog 2>&1

cd /var/www/demo.com
sudo mv htaccess.txt .httaccess
sudo chmod 755 .htaccess
sudo find . -type f -exec chmod 655 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo chown -R www-data:www-data /var/www/demo.com/
sudo service apache2 restart

