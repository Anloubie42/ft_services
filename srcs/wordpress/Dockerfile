from alpine:3.11

RUN apk update && \
    apk add nginx && \
    apk add php7-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom && \
    mkdir -p /usr/share/webapps && \
    wget http://wordpress.org/latest.tar.gz && \
    mkdir -p /var/www/html && \
    tar -xzvf latest.tar.gz -C /var/www/html && \
    rm latest.tar.gz && \
    mkdir -p /run/nginx/ && \
    rm /etc/nginx/conf.d/default.conf && \
    ln -s /var/www/html/wordpress/ /var/www/localhost/htdocs/wordpress && \
    mkdir -p /var/run/php

EXPOSE 5050

ADD ./srcs/nginx.conf /etc/nginx/conf.d/
COPY ./srcs/init.sh .

CMD sh init.sh

# apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom && \
# apk -f add php7-fpm php7-mbstring php7-session php7-mysqli php7-gettext php7-pdo php7-zip php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom