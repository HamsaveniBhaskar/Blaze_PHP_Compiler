#!/bin/bash

# Update apt and install PHP
apt-get update
apt-get install -y \
    php-cli \
    php-mbstring \
    php-xml \
    php-json \
    php-curl \
    build-essential

# Debug PHP installation
echo "PHP version:"
php -v  # This will print the PHP version
echo "PHP path:"
which php  # This will print the PHP path

# Install Node.js dependencies
npm install
