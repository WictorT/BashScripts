mkdir $1 &&
touch /etc/apache2/sites-available/$1.conf &&
echo '
	<VirtualHost *:80>
		ServerName '$1'.local
		ServerAdmin webmaster@localhost

		DocumentRoot /var/www/'$1'

		ErrorLog ${APACHE_LOG_DIR}/'$1'_error.log
		CustomLog ${APACHE_LOG_DIR}/'$1'_access.log combined

		ProxyPassMatch "^/(.*\.php(/.*)?)$" "unix:/run/php/php7.0-fpm.sock|fcgi://localhost/var/www/'$1'/"
	</VirtualHost>
' >> /etc/apache2/sites-available/$1.conf &&

echo '127.0.0.1 '$1'.local' >> /etc/hosts &&
a2ensite $1'.conf' && 
service apache2 reload &&
echo '<?php
		phpinfo();
		?>' >> $1'/index.php';
