# Use the official PHP 8.0.2 image as the base
FROM php:8.1-cli

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY ./ ./

# Install necessary PHP extensions and other dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    && docker-php-ext-install \
    bcmath \
    pdo_mysql

# Install Nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && apt-get install -y nodejs

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set permissions for user
RUN chown -R www-data:www-data /var/www/html

# Install Composer dependencies
RUN composer install 

# Install npm dependencies
RUN npm install

EXPOSE 8000

# Start the PHP built-in web server
CMD ["tail", "-f", "/dev/null"]
# CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8080" ]
