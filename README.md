Vagrantfile - This script automates provisioning of two Ubuntu servers, on master a bash script to deploy LAMP
lampstack.sh - What this script does:

1. Updates the packages
2. Install Apache web server
3. Install PHP
4. Install MYSQL
5. Setting Permissions
6. Enabling Modules


Install Laravel Application:
Then Git clone Laravel application onto server.

Run Composer which installs laravel dependencies.
Laravel Permissions  - with Linux file permissions.

Database Setup:
Database of the Laravel application in production.

**combined_script.sh**: Contains the LAMP stack setup together with the PHP Configuration

**env_variables.sh**: Adding database credentials.
Adding APP_ENV key to production since the production and also turn the APP_DEBUG key to false.

**configure_php.sh**: Installs PHP, open php.ini file, installs composer


## STEPS:
## ISSUES ENCOUNTED:

