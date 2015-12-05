FROM justcontainers/base-alpine

ENV BASE_PACKAGES  fish curl
ENV WEB_PACKAGES   nginx ca-certificates
ENV PHP_PACKAGES   php-fpm php-cli php-json php-xml php-zlib \
                   php-curl php-pdo php-phar php-openssl \
                   php-pdo_mysql php-mysqli php-dom \
                   php-gd php-iconv php-mcrypt php-ctype
                  
# Install packages
RUN apk update && \
    apk upgrade && \
    apk add $BASE_PACKAGES && \
    apk add $WEB_PACKAGES && \
    apk add $PHP_PACKAGES && \
    rm -rf /var/cache/apk/*
    
# Copy configuration files to root
COPY rootfs /

# Fix permissions
RUN chown -Rf nginx:www-data /app

# Define mountable directories
VOLUME ["/app", "/etc/nginx/certs"]

# Set working directory
WORKDIR /app

# Expose ports
EXPOSE 80 443