#!/bin/bash

# Install PHP and verify installation
apt-get update
apt-get install -y php-cli php-common php-curl php-xml php-json

# Verify PHP installation
php -v
which php

# Install Node.js dependencies
npm install
