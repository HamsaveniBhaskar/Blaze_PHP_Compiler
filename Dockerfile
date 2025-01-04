# Use official PHP image (7.4 FPM) as the base image
FROM php:7.4-fpm

# Install system dependencies and PHP extensions for gd, mbstring, and xml
RUN apt-get update \
    && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libxml2-dev \
    libc-dev \
    gcc \
    make \
    && echo "Dependencies installed" \
    # Install PHP extensions
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install xml \
    && echo "Extensions installed successfully" \
    || { echo "apt-get or php-ext installation failed"; tail -n 50 /var/log/apt/term.log; exit 1; }

# Set working directory
WORKDIR /app

# Copy all project files into the working directory in the container
COPY . .

# Install Node.js dependencies (if applicable)
RUN npm install

# Expose the port your app will run on
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]
