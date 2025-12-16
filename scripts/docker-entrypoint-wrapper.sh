#!/bin/bash
set -e

# Fix ownership of wp-content directories for www-data (UID 33)
chown -R www-data:www-data /var/www/html/wp-content/themes 2>/dev/null || true
chown -R www-data:www-data /var/www/html/wp-content/plugins 2>/dev/null || true
chown -R www-data:www-data /var/www/html/wp-content/uploads 2>/dev/null || true

# Call the original WordPress entrypoint
exec docker-entrypoint.sh "$@"
