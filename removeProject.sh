rm -rf $1 /etc/apache2/sites-available/$1.conf &&
a2dissite $1.conf &&
sed '/'$1'.local/d' /etc/hosts &&
service apache2 reload
