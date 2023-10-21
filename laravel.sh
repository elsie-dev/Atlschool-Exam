 sudo chown -R www-data:www-data /var/www/html/laravel

sudo chmod -R 775 /var/www/html/laravel

sudo chmod -R 775 /var/www/html/laravel/laravel/storage

sudo chmod -R 775 /var/www/html/laravel/laravel/bootstrap/cache


..................
 nano lamp_setup.sh
    2  chmod +x lamp_setup.sh
    3  ./lamp_setup.sh
    4  nano lamp_setup.sh
    5  ./lamp_setup.sh
    6  sudo nano /var/www/html/test.php
    7  sudo nano /etc/php/8.2/apache2/php.ini
    8  php --version
    9  nano lamp_setup.sh
   10  php --ini
   11  sudo nano /etc/php/7.2/cli/php.ini
   12  sudo systemctl restart apache2
   13  curl -sS https://getcomposer.org/installer | php
   14  sudo nano /etc/php/7.2/cli/php.ini
   15  curl -sS https://getcomposer.org/installer | php
   16  sudo mv composer.phar /usr/local/bin/composer
   17  sudo chmod +x /usr/local/bin/composer
   18  sudo nano /etc/apache2/sites-available/laravel.conf
   19  sudo a2enmod rewrite
   20  sudo a2ensite laravel.conf
   21  systemctl reload apache2
   22  sudo systemctl reload apache2
   23  composer create-project --prefer-dist laravel/laravel altschool
   24  cd altschool
   25  php artisan serve --host=192.168.56.26 --port=80
   26  php artisan serve --host=192.168.56.26 --port=8000
   27  sudo mv altschool /var/www/html
   28  cd ..
   29  sudo mv altschool /var/www/html
   30  sudo nano /etc/apache2/sites-available/laravel.conf
   31  sudo a2enmod rewrite
   32  sudo a2ensite laravel.conf
   33  sudo systemctl restart apache2
   34  mkdir /var/www/html/laravel && cd /var/www/html/laravel
   35  sudo mkdir /var/www/html/laravel && sudo cd /var/www/html/laravel
   36  sudo mkdir /var/www/html/laravel 
   37  cd /var/www/html/laravel
   38  cd 
   39  cd /var/www/html/laravel
   40  git clone https://github.com/laravel/laravel.git
   41  sudo git clone https://github.com/laravel/laravel.git
   42  composer install --no-dev
   43  cd laravel
   44  ls
   45  composer install --no-dev
   46  sudo chown -R www-data:www-data /var/www/html/laravel
   47  sudo chmod -R 775 /var/www/html/laravel
   48  sudo chmod -R 775 /var/www/html/laravel/storage
   49  sudo chmod -R 775 /var/www/html/laravel/bootstrap/cache
   50  sudo chmod -R 775 /var/www/html/laravel/laravel/storage
   51  sudo chmod -R 775 /var/www/html/laravel/laravel/bootstrap/cache
   52  cp .env.example .env
   53  php artisan key:generate
   54  sudo cp .env.example .env
   55  php artisan key:generate
   56  composer update
   57  cd 
   58  history

# mysql login
sudo mysql_secure_installation -y
sudo mysql -u root
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'new_password';

FLUSH PRIVILEGES;
EXIT;
mysql -u root -p

