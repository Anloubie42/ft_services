php-fpm7
nginx
mysql -h mysql --user=wproot --password=wppassword
while [ $?==1 ]; do
	mysql -h mysql --user=wproot --password=wppassword
	sleep 1
done
while pgrep nginx > /dev/null; do
	sleep 1;
done
