# Dockerized WordPress Setup

A complete WordPress development environment with Docker, providing direct access to themes, plugins, and configuration files.

## Structure

```
dockerized-wordpress/
├── docker-compose.yml
├── config/
│   └── php.ini
├── wp-content/
│   ├── themes/
│   ├── plugins/
│   └── uploads/
└── scripts/
    └── cron.sh
```

## Quick Start

1. **Start the environment:**
   ```bash
   docker-compose up -d
   ```

2. **Access WordPress:**
   - URL: http://localhost:8080
   - Complete the WordPress installation wizard

3. **Stop the environment:**
   ```bash
   docker-compose down
   ```

## Working with Files

### Themes
- Location: `./wp-content/themes/`
- Create custom themes here or modify existing ones
- Changes are immediately reflected in the container

### Plugins
- Location: `./wp-content/plugins/`
- Add custom plugins or modify existing ones

### Uploads
- Location: `./wp-content/uploads/`
- All media uploads are stored here

### PHP Configuration
- Location: `./config/php.ini`
- Modify PHP settings (upload limits, memory, etc.)
- Restart containers after changes: `docker-compose restart wordpress`

## Cron Jobs

### Manual Cron Execution
Run WordPress cron manually:
```bash
docker-compose exec wpcli wp cron event run --due-now --path=/var/www/html
```

### Custom Cron Script
Use the provided cron script:
```bash
./scripts/cron.sh
```

### Setup System Cron (macOS/Linux)
Add to your crontab (`crontab -e`):
```
*/15 * * * * cd /Users/marcosfermin/scripts/dockerized-wordpress && ./scripts/cron.sh
```

### View Scheduled Cron Events
```bash
docker-compose exec wpcli wp cron event list --path=/var/www/html
```

## Useful Commands

### WordPress CLI
Access WP-CLI:
```bash
docker-compose exec wpcli wp --info --path=/var/www/html
```

### Database Access
```bash
docker-compose exec db mysql -u wordpress -pwordpress_password wordpress
```

### View Logs
```bash
docker-compose logs -f wordpress
```

### Install Plugins via CLI
```bash
docker-compose exec wpcli wp plugin install <plugin-name> --activate --path=/var/www/html
```

### Update WordPress Core
```bash
docker-compose exec wpcli wp core update --path=/var/www/html
```

## Backup & Restore

### Backup Database
```bash
docker-compose exec db mysqldump -u wordpress -pwordpress_password wordpress > backup.sql
```

### Restore Database
```bash
docker-compose exec -T db mysql -u wordpress -pwordpress_password wordpress < backup.sql
```

## Troubleshooting

### Reset Permissions
```bash
docker-compose exec wordpress chown -R www-data:www-data /var/www/html/wp-content
```

### Clear All Data
```bash
docker-compose down -v
rm -rf wp-content/
```
