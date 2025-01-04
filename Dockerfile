# Use official PHP image (7.4 FPM) as the base image
FROM php:7.4-fpm

# Install system dependencies and PHP extensions for gd, mbstring, and xml
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libxml2-dev \
    libc-dev \
    gcc \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install xml

# Set working directory
WORKDIR /app

# Copy all project files into the working directory in the container
COPY . .

# Install Node.js dependencies (if you have a Node.js-based project)
RUN npm install

# Expose the port that your app will run on
EXPOSE 3000

# Start the application (modify based on how your app starts)
CMD ["npm", "start"]
