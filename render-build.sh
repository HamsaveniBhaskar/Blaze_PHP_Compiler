#!/bin/bash

# Update apt and install PHP and necessary packages
apt-get update
apt-get install -y \
    php-cli \
    php-mbstring \
    php-xml \
    php-json \
    php-curl \
    build-essential

# Install Node.js dependencies
npm install
