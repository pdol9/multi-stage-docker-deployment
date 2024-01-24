#!/bin/sh

while ! mariadb -h${DB_HOST} -u${WP_DB_USER} -p${WP_DB_PASS} ${WP_DB_NAME} &>/dev/null;
do
    sleep 5
done

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	wp-cli.phar cli update --yes --allow-root
	wp-cli.phar core download --allow-root
	wp-cli.phar config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS} --dbhost=${DB_HOST} --path=${WP_PATH} --allow-root
	wp-cli.phar core install --url=pdolinar.42.fr/wordpress --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --path=${WP_PATH} --allow-root
	wp-cli.phar user create $WP_USER ${WP_USER_EMAIL} --user_pass=${WP_USER_PASS} --role=subscriber --display_name=${WP_USER} --porcelain --path=${WP_PATH} --allow-root
	wp-cli.phar theme install twentytwentytwo --path=${WP_PATH} --activate --allow-root
	wp-cli.phar theme status twentytwentytwo --allow-root
fi

exec /usr/sbin/php-fpm81 -F -R

