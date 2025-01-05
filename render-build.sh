#!/bin/bash
# Install dependencies for PHP and Node.js
echo "Installing dependencies..."
apt-get update

# Install PHP and necessary extensions
apt-get install -y php-cli php-common php-mbstring

# Install Node.js dependencies
npm install

echo "Dependencies installed successfully."

# Run the server
echo "Starting the server..."
npm start
