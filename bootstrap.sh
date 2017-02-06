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

echo -e "\n--- Installa phpMyAdmin ---\n"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

echo -e "\n--- Crea VirtualHost ---\n"
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html">
        Options Indexes FollowSymLinks
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

echo -e "\n--- Abilita mcrypt per phpMyAdmin ---\n"
sudo updatedb
sudo sed -i 's#extension=mcrypt.so#extension=/usr/lib/php5/20121212/mcrypt.so#g' /etc/php5/mods-available/mcrypt.ini
sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini
sudo ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
sudo service apache2 restart
sudo service php5 restart

echo -e "\n--- Installa GIT ---\n"
sudo apt-get -y install git

echo -e "\n--- Installa Composer ---\n"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo -e "\n--- Installa Nodejs e npm ---\n"
sudo apt-get update 
sudo apt-get -y install nodejs
sudo ln -s "$(which nodejs)" /usr/bin/node
sudo apt-get -y install npm

echo -e "\n--- Installa Gulp ---\n"
npm install --global gulp-cli
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

echo -e "\n--- Installa Gulp Sass ---\n"
npm install --global gulp-sass

echo -e "\n--- Installa Browser Sync ---\n"
npm install --global browser-sync