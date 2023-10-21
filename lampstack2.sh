#!/bin/bash

echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "\n\nInstalling Apache2 Web server\n"
sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

echo -e "\n\nInstalling PHP & Requirements\n"
sudo apt-get install libapache2-mod-php7.0 php7.0 php7.0-common php7.0-curl php7.0-dev php7.0-gd php-pear php7.0-mcrypt php7.0-mysql -y

echo -e "\n\nInstalling MySQL\n"
sudo apt-get install mysql-server mysql-client -y

echo -e "\n\nPermissions for /var/www\n"
sudo chown -R www-data:www-data /var/www
echo -e "\n\nPermissions have been set\n"

echo -e "\n\nEnabling Modules\n"
sudo a2enmod rewrite
sudo phpenmod mcrypt

echo -e "\n\nCloning PHP Application from GitHub (Laravel)\n"
# Clone Laravel from GitHub
cd /var/www/html
sudo git clone https://github.com/laravel/laravel.git .

# Install Composer (a PHP package manager)
sudo apt-get install composer -y
cd /var/www/html
sudo composer install

# Set the correct permissions for Laravel
sudo chown -R www-data:www-data /var/www/html/myapp/storage /var/www/html/myapp/bootstrap/cache
sudo chmod -R 755 /var/www/html/myapp/storage /var/www/html/myapp/bootstrap/cache


# updating ENV File and Generate an encryption key
cd /var/www/html
cp .env.example .env
php artisan key:generate

echo -e "\n\nUpdating .env file\n"
# Use a text editor like nano to update the .env file
nano .env

# Using sed to update .env if you prefer non-interactive editing
sed -i "s/DB_HOST=YOUR_DB_HOST/DB_HOST=your_db_host/" .env
sed -i "s/DB_DATABASE=altschoolexam/DB_DATABASE=altschoolexam/" .env
sed -i "s/DB_USERNAME=admin/DB_USERNAME=elcyma/" .env
sed -i "s/DB_PASSWORD=123abc/DB_PASSWORD=123abc/" .env


echo -e "\n\n.env file updated"

sudo tee /etc/apache2/sites-available/altschool.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin elcymao@gmail.com
    ServerName techvblogs.com
    DocumentRoot /var/www/html/public

    <Directory /var/www/html/public>
       Options +FollowSymlinks
       AllowOverride All
       Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable the Laravel virtual host
sudo a2ensite myapp



echo -e "\n\nRestarting Apache\n"
sudo service apache2 restart

echo -e "\n\nLAMP Installation Completed"

exit 0
