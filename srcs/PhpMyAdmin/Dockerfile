from alpine:3.11

RUN apk update && \
	apk add nginx && \
	apk add mysql mysql-client && \
	apk add php7 php7-mbstring php7-session php7-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom && \
	mkdir -p /usr/share/webapps/ && \
	cd /usr/share/webapps/ && \
	wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
	tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && \
	rm phpMyAdmin-5.0.2-all-languages.tar.gz && \
	mkdir -p /run/nginx/ && \
	rm /etc/nginx/conf.d/default.conf && \
	mv phpMyAdmin-5.0.2-all-languages phpmyadmin && \
	chmod -R 777 /usr/share/webapps/ && \
	ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin

EXPOSE 5000

ADD ./srcs/init.sh .
COPY ./srcs/nginx.conf /etc/nginx/conf.d/
COPY ./srcs/config.inc.php usr/share/webapps/phpmyadmin/

CMD sh init.sh
