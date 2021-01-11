mysql -h mysql --user=wproot --password=wppassword
while [ $? != 0 ]; do
	mysql -h mysql --user=wproot --password=wppassword
	sleep 2
done
mysql -h mysql --user=wproot --password=wppassword -se'USE wordpress;'
while [ $? != 0 ]; do
	mysql --host=mysql --user=wproot --password=wppassword -se'CREATE DATABASE IF NOT EXISTS wordpress;'
	mysql --host=mysql --user=wproot --password=wppassword wordpress < /wordpress.sql
	mysql --host=mysql --user=wproot --password=wppassword -se'USE wordpress;'
done
php-fpm7
nginx
while pgrep nginx > /dev/null && pgrep php-fpm7 > /dev/null; do
	sleep 1;
done
