# Set the base image
FROM php:8.1-apache
# Install necessary dependencies
RUN apt-get update && apt-get install -y \
  libonig-dev \
  libzip-dev \
  unzip \
  && docker-php-ext-install pdo_mysql mbstring zip

# Copy and install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy project files into the container
COPY . /var/www/html

# Set proper permissions on directories
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Set required environment variables
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# Configure Apache
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN a2enmod rewrite

# Install project dependencies
RUN composer install --optimize-autoloader --no-dev

# Open port for accessing the application
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
