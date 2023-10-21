# Installing LAMP  on Master node

#!/bin/bash

echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "\n\nInstalling Apache2 Web server\n"
echo -e "\n\nInstalling PHP & Requirements\n"
sudo apt-get update
sudo apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get update
sudo apt-get install -y apache2 mysql-server php8.0 php8.0-mysql

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


# Configuring PHP , then setting up Laravel 
php_ini_file="/etc/php/8.2/apache2/php.ini"

# Check if the file exists before making changes
if [ -f "$php_ini_file" ]; then
    # Remove the semicolon and set the value to 0
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' "$php_ini_file"
    
    # Increase memory limit
    sed -i 's/memory_limit = 128M/memory_limit = 256M/g' "$php_ini_file"

    # Restart Apache to apply changes
    sudo systemctl restart apache2
    echo "PHP configuration updated, and Apache restarted."

    # Install Composer
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    echo "Composer installed."

else
    echo "php.ini file not found. Please check the file path."
fi


# Configure Apache to host Laravel Application 

laravel_dir="/var/www/html/laravel"
laravel_domain="yourdomain.com"

# Create an Apache virtual host configuration file
cat <<EOF > /etc/apache2/sites-available/laravel.conf
<VirtualHost *:80>
    ServerAdmin elcymao@gmail.com
    DocumentRoot  /var/www/html/laravel/public

    <Directory /var/www/html/laravel>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable the virtual host and Apache modules
a2ensite laravel.conf
a2enmod rewrite

# Restart Apache to apply the changes
sudo systemctl restart apache2

echo "Apache configuration for Laravel application completed."

# Creating Laravel application and navigating to it 
mkdir -p /var/www/html/laravel
#cd /var/www/html/laravel

#Installing Git
if ! command -v git &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y git
fi

git clone https://github.com/laravel/laravel.git /var/www/html/laravel

cd /var/www/html/laravel

composer install --no-dev

# Set proper ownership and permissions for the Laravel directory
sudo chown -R www-data:www-data /var/www/html/laravel/
sudo chmod -R 775 /var/www/html/laravel/
sudo chmod -R 775 /var/www/html/laravel/storage
sudo chmod -R 775 /var/www/html/laravel/bootstrap/cache

# Copy the example environment file and generate the application key
cp .env.example .env
php artisan key:generate


echo 'Laravel webapp succesfully working"



# .env variables for the secrets 

# Check if the .env file exists
env_file="/var/www/html/laravel/.env"
if [ ! -f "$env_file" ]; then
    echo "The .env file does not exist at $env_file. Please check the file path."
    exit 1
fi

# Edit the .env file using sudo and nano
sudo nano "$env_file"

# Update the APP_ENV and APP_DEBUG values
sed -i 's/^APP_ENV=.*/APP_ENV=production/' "$env_file"
sed -i 's/^APP_DEBUG=.*/APP_DEBUG=false/' "$env_file"

echo "APP_ENV set to 'production' and APP_DEBUG set to 'false' in the .env ."
