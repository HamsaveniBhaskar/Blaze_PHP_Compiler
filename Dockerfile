# Use official Node.js image as base for Node.js
FROM node:16 as node-builder

# Set working directory
WORKDIR /app

# Copy only package.json into the image
COPY package.json ./

# Install dependencies using npm
RUN npm install

# Copy the rest of your application code
COPY . .

# Use official PHP image (7.4 FPM or 7.4 Apache)
FROM php:7.4-fpm

# Install necessary PHP extensions (if they aren't already part of the image)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mbstring xml

# Copy the Node.js app from the node-builder image
COPY --from=node-builder /app /app

# Set the working directory to /app
WORKDIR /app

# Expose port 3000
EXPOSE 3000

# Command to run when the container starts
CMD ["npm", "start"]
