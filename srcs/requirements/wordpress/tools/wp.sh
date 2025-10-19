#!/bin/sh

if [ ! -f /var/www/html/first ]; then

chown -R nobody:nobody /var/www/html/wp-content
chmod -R g+w /var/www/html/wp-content

mariadb-admin ping --protocol=tcp --host=mariadb -u "$wp_user" --password="$(cat /run/secrets/db_user_pass)" --wait >/dev/null 2>/dev/null

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp config create --allow-root \
	--dbhost=mariadb \
	--dbuser="$wp_user" \
	--dbpass="$(cat /run/secrets/db_user_pass)" \
	--dbname="$wordpress"

wp config set WP_REDIS_HOST redis
wp config set WP_REDIS_PORT 6379 --raw
wp config set WP_CACHE true --raw
wp config set FS_METHOD direct

wp core install \
  --url="$website_url" \
  --title="Inception" \
  --admin_user="$wp_admin" \
  --admin_password="$(cat /run/secrets/wp_root_pass)" \
  --admin_email="$admin_email"

wp user create $wp_editor $editor_email --role=editor --user_pass=$(cat /run/secrets/wp_user_pass)

apk add redis
until redis-cli -h redis ping | grep -q PONG; do
  echo "Waiting for Redis..."
  sleep 1
done

cd /var/www/html/wp-content/plugins/
wget -O redis-cache.zip https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip
unzip redis-cache.zip -d .
rm redis-cache.zip

cd /var/www/html
wp plugin activate redis-cache
wp redis enable

touch /var/www/html/first

fi

exec php-fpm83 -F
