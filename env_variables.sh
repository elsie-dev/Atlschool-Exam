#!/bin/bash

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

