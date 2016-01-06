FROM cubez/base
MAINTAINER cubez <cubez@cubez.nl>

# Variables
ENV PACKAGES  nginx ca-certificates \
              php-fpm php-cli php-json php-xml php-zlib \
              php-curl php-pdo php-phar php-openssl \
              php-pdo_mysql php-mysqli php-mysql php-dom \
              php-gd php-iconv php-mcrypt php-ctype php-zip
                  
# Install packages
RUN apk --no-cache add $PACKAGES
    
# Copy root files
COPY rootfs /

# Fix permissions
RUN chown -Rf nginx:www-data /app && \
    chown -Rf nginx:www-data /var/lib/nginx

# Define mountable directories
VOLUME ["/app", "/etc/nginx/certs"]

# Set working directory
WORKDIR /app

# Expose ports
EXPOSE 80 443