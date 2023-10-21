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

#php setup
# Install PHP 8.0 and some common extensions
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Update and upgrade again
sudo apt update
sudo apt upgrade -y

# Install PHP 8 and modules
php8_and_modules="php8.1 libapache2-mod-php8.1 php8.1-cli php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl php8.1-bcmath"
apt install -y $php8_and_modules


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


