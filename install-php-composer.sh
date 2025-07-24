#!/bin/bash

echo "🚀 Starting installation of PHP 8.3.20 and Composer 2.8.8 for Laravel..."

# Install PHP
if ! command -v php &> /dev/null; then
    echo "📦 PHP not found, installing..."
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install -y php8.3 php8.3-cli php8.3-common
else
    echo "✅ PHP is already installed"
fi

# Install Laravel required extensions
echo "🔧 Installing Laravel required PHP extensions..."
sudo apt-get install -y \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-bcmath \
    php8.3-curl \
    php8.3-zip \
    php8.3-mysql \
    php8.3-pgsql \
    php8.3-readline \
    php8.3-gd \
    php8.3-opcache \
    php8.3-intl

# Install Composer
if ! command -v composer &> /dev/null; then
    echo "📦 Composer not found, installing..."
    EXPECTED_SIGNATURE=$(wget -qO - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('sha384', 'composer-setup.php');")

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo '❌ ERROR: Invalid installer signature for Composer!'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --version=2.8.8
    sudo mv composer.phar /usr/local/bin/composer
    rm composer-setup.php

    echo "✅ Composer 2.8.8 installed successfully"
else
    echo "✅ Composer is already installed"
fi

# Show installed versions
echo ""
echo "📌 Installed versions:"
php -v
composer -V

# Show enabled extensions
echo ""
echo "🧩 Enabled PHP extensions:"
php -m | grep -E 'mbstring|xml|bcmath|curl|zip|pdo|mysql|pgsql|readline|gd|intl|openssl|opcache'

echo ""
echo "✅ All components installed successfully!"
