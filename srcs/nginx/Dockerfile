from alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl \
	&& apk add openssh

RUN	apk add php7 php7-mbstring php7-session php7-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom


RUN mkdir /run/nginx && touch /run/nginx/nginx.pid && mkdir -p /usr/share/nginx/html
RUN adduser nginx nginx
RUN chown -R nginx:nginx /etc/nginx

RUN	touch /run/nginx/nginx.pid \
	&& rm /etc/nginx/conf.d/default.conf \
	&& mkdir -p /var/www/html \
	&& openssl req -nodes -batch -newkey rsa:2048 -keyout /etc/ssl/certifssl.key -out /etc/ssl/certifssl.csr \
	&& openssl x509 -req -in /etc/ssl/certifssl.csr -signkey /etc/ssl/certifssl.key -out /etc/ssl/certifssl.crt -days 999

RUN apk add openrc --no-cache

RUN	mkdir /run/openrc \
	&& rc-update add sshd \
	&& touch /run/openrc/softlevel

ADD ./srcs/nginx.conf /etc/nginx/conf.d/
ADD ./srcs/index.html /var/www/html/
COPY ./srcs/init.sh .
COPY ./srcs/proxy_params /etc/nginx/

RUN	rm /etc/ssh/sshd_config
COPY ./srcs/sshd_config /etc/ssh/

CMD sh init.sh
