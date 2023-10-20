
#!/bin/bash

# Update apt packages and upgrade latest patches
echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"
sudo apt-get update -y && sudo apt-get upgrade -y

# Install Apache2 web server
echo -e "\n\nInstalling Apache2 Web server\n"
sudo apt-get install apache2 -y

# Install PHP and its requirements
echo -e "\n\nInstalling PHP & Requirements\n"
sudo apt-get install libapache2-mod-php7.0 php7.0 php7.0-common php7.$

# Install MySQL
echo -e "\n\nInstalling MySQL\n"
sudo apt-get install mysql-server mysql-client -y

# Set permissions for /var/www
echo -e "\n\nPermissions for /var/www\n"
sudo chown -R www-data:www-data /var/www
echo -e "\n\nPermissions have been set\n"

# Enable Apache modules
echo -e "\n\nEnabling Modules\n"
sudo a2enmod rewrite
sudo phpenmod mcrypt

# Clone Laravel from GitHub
echo -e "\n\nCloning PHP Application from GitHub (Laravel)\n"
cd /var/www/html  # Change to the desired directory
sudo git clone https://github.com/laravel/laravel.git .
# Install Composer
sudo apt-get install composer -y
# Set the correct permissions for Laravel
sudo chown -R www-data:www-data /var/www/html/storage /var/www/html/b$
sudo chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Update .env file and generate an encryption key
sudo chmod -R 775  /var/www/html
cp .env.example .env
php artisan key:generate

# Use a text editor like nano to update the .env file
echo -e "\n\nUpdating .env file\n"
sudo chmod 775 .env
nano .env

# Using sed to update .env if you prefer non-interactive editing
sed -i "s/DB_HOST=YOUR_DB_HOST/DB_HOST=your_db_host/" .env
sed -i "s/DB_DATABASE=altschoolexam/DB_DATABASE=altschoolexam/" .env
sed -i "s/DB_USERNAME=admin/DB_USERNAME=elcyma/" .env
sed -i "s/DB_PASSWORD=123abc/DB_PASSWORD=123abc/" .env

# Create an Apache virtual host configuration
echo -e "\n\nConfiguring Apache Virtual Host for Laravel\n"
sudo tee /etc/apache2/sites-available/altschool.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin elcymao@gmail.com
    ServerName altschoolexam
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
sudo a2ensite altschool

# Restart Apache to apply changes
echo -e "\n\nRestarting Apache\n"
sudo service apache2 restart

echo -e "\n\nLAMP Installation Completed"
