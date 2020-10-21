mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mysqld --user=root --bootstrap --verbose=0 --skip-grant-tables=0 < admin.sql
mysqld --user=root --console