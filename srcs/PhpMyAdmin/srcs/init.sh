php-fpm7
nginx
# mysql -h mysql --user=wproot --password=wppassword
# while [ $?!=0 ]; do
# 	echo "looping"
# 	mysql -h mysql --user=wproot --password=wppassword
# 	sleep 1
# done
while pgrep nginx > /dev/null && pgrep php-fpm7 > /dev/null; do
	sleep 1;
done
