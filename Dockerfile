# Use an official PHP image as a parent image
FROM php:8.2-fpm

# Set the working directory in the container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    zip \
    unzip \
    curl \
    libonig-dev \
    libxml2-dev \
    git \
    npm \
    yarn

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql mbstring xml

# Install Composer globally (example with Composer version 2)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the Laravel application code to the container
COPY ./app .

RUN composer clear-cache

# Install Laravel dependencies
RUN composer install

# Generate the Composer autoloader
RUN composer dump-autoload

# Set permissions for Laravel storage and bootstrap folders
RUN chmod -R 777 storage bootstrap/cache

# Expose the port your Laravel app will run on (usually 9000)
EXPOSE 9000

# Define the command to run your Laravel app
CMD ["php-fpm"]
