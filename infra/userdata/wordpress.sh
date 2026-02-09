#!/bin/bash
set -eux

# Variables injected by Terraform
DB_NAME="${db_name}"
DB_USER="${db_username}"
DB_PASS="${db_password}"
DB_HOST="${db_endpoint}"

# Update system
dnf update -y

# Install Apache, PHP, MySQL client
dnf install -y httpd php php-mysqlnd wget unzip

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Download WordPress
cd /tmp
wget https://wordpress.org/latest.zip
unzip latest.zip

# Move WordPress files
cp -r wordpress/* /var/www/html/

# Set permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Create wp-config.php
cd /var/www/html
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/${db_name}/" wp-config.php
sed -i "s/username_here/${db_username}/" wp-config.php
sed -i "s/password_here/${db_password}/" wp-config.php
sed -i "s/localhost/${db_endpoint}/" wp-config.php

# Restart Apache
systemctl restart httpd
