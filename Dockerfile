# Use official Node.js image as base for Node.js
FROM node:16 as node-builder

# Set working directory for Node.js
WORKDIR /app

# Copy only package.json into the image
COPY package.json ./

# Install dependencies using npm
RUN npm install

# Copy the rest of your application code
COPY . .

# Use official PHP image (7.4 FPM)
FROM php:7.4-fpm

# Install system dependencies and PHP extensions for gd, mbstring, and xml
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring xml \
    || { echo "apt-get failed"; tail -n 50 /var/log/apt/term.log; exit 1; }

# Verify PHP installation and installed extensions
RUN php -v && php -m

# Copy the Node.js app from the node-builder image
COPY --from=node-builder /app /app

# Set the working directory to /app
WORKDIR /app

# Expose port 3000
EXPOSE 3000

# Command to run when the container starts
CMD ["npm", "start"]
