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

# Confirm PHP installation
php -v  # This will print the PHP version

# Install Node.js dependencies
npm install
