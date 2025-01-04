# Use a PHP image as the base
FROM php:8.1-cli

# Install Node.js and dependencies
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    curl \
    git

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package.json package-lock.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]
