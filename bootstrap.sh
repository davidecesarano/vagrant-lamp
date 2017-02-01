!/usr/bin/env bash

PASSWORD='vagrant'

echo -e "\n--- Aggiorna l'indice dei pacchetti ---\n"
sudo apt-get update

echo -e "\n--- Installa Apache ---\n"
sudo apt-get install -y apache2

echo -e "\n--- Installa PHP ---\n"
sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-cgi php5-cli php5-curl

echo -e "\n--- Installa MySQL ---\n"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql

echo -e "\n--- Crea VirtualHost ---\n"
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

echo -e "\n--- Crea index.php ---\n"
sudo rm /var/www/html/index.html
sudo touch /var/www/html/index.php
echo "<?php phpinfo(); ?>" > /var/www/html/index.php

echo -e "\n--- Attiva mod_rewrite ---\n"
sudo a2enmod rewrite

echo -e "\n--- Restart Apache ---\n"
sudo service apache2 restart

echo -e "\n--- Ferma MySQL ---\n"
sudo /etc/init.d/mysql stop

echo -e "\n--- Copia database MySQL in /var/www/mysql ---\n"
sudo cp -Rp /var/lib/mysql /var/www

echo -e "\n--- Cambia percorso directory database MySQL ---\n"
sudo sed -i 's#/var/lib/mysql#/var/www/mysql#g' /etc/mysql/my.cnf
sudo sed -i 's#/var/lib/mysql#/var/www/mysql#g' /etc/apparmor.d/usr.sbin.mysqld
sudo /etc/init.d/apparmor reload

echo -e "\n--- Installa GIT ---\n"
sudo apt-get -y install git

echo -e "\n--- Installa Composer ---\n"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo -e "\n--- Installa Node.js ---\n"
sudo apt-get -y install nodejs

echo -e "\n--- Installa NPM ---\n"
sudo apt-get -y install npm

echo -e "\n--- Installa Bower ---\n"
sudo npm install bower -g