# Installing LAMP  on Master node

#!/bin/bash

echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "\n\nInstalling Apache2 Web server\n"
echo -e "\n\nInstalling PHP & Requirements\n"
#sudo apt-get update
#sudo apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common
#sudo add-apt-repository -y ppa:ondrej/php

#sudo apt-get update
#sudo apt-get install -y apache2 mysql-server php8.0 php8.0-mysql


sudo apt install apt-transport-https lsb-release ca-certificates wget -y
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg 
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
sudo apt update

sudo apt install libapache2-mod-php8.2

echo -e "\n\nPermissions for /var/www\n"
sudo chown -R www-data:www-data /var/www
echo -e "\n\n Permissions have been set\n"

echo -e "\n\nEnabling Modules\n"
cp /home/elcymarion/altschoolexam/laravel.conf /etc/apache2/sites-available/laravel.conf
sudo a2enmod rewrite
sudo a2ensite laravel.conf

echo -e "\n\nRestarting Apache\n"
sudo systemctl restart apache2

echo -e "\n\Development Database and securing it\n"
sudo mysql_secure_installation
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password  Mk#yamaha'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password Mk#yamaha'

echo "CREATE DATABASE altschool;" | mysql
echo "GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';"
echo "flush privileges;" | mysql

echo -e "\n\nLAMP Installation Completed"

exit 0


