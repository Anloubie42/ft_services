CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wproot'@'%' IDENTIFIED BY 'wppassword' WITH GRANT OPTION;
FLUSH PRIVILEGES;
