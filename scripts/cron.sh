#!/bin/bash

# WordPress Cron Job Runner
# This script triggers WordPress cron jobs via WP-CLI

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR" || exit 1

# Check if Docker containers are running
if ! docker-compose ps | grep -q "wordpress_cli"; then
    echo "WordPress containers are not running. Skipping cron."
    exit 0
fi

# Run WordPress cron
docker-compose exec -T wpcli wp cron event run --due-now --path=/var/www/html

# Log the execution
echo "$(date): WordPress cron executed" >> "$PROJECT_DIR/cron.log"
