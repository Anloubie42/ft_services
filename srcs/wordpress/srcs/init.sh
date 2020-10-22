php-fpm7
nginx
mysql --host=mysql --user=wproot --password=wppassword < admin.sql
while [ $?==1 ]; do
	mysql --host=mysql --user=wproot --password=wppassword < admin.sql
	sleep 1
done
while pgrep nginx > /dev/null; do
	sleep 1;
done