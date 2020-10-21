php-fpm7
nginx
mysql -h mysql -u wproot -pwppassword < admin.sql
while [ $?==1 ]; do
    mysql -h mysql -u wproot -pwppassword < admin.sql
    sleep 1
done
while pgrep nginx > /dev/null; do
    sleep 1;
done