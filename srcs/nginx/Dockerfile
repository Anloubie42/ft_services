from alpine:3.11

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl \
	&& adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www \
	&& apk add openrc --no-cache \
	&& mkdir /run/nginx \
	&& touch /run/nginx/nginx.pid \
	&& rm /etc/nginx/conf.d/default.conf \
	&& mkdir -p /var/www/html \
	&& openssl req -nodes -batch -newkey rsa:2048 -keyout /etc/ssl/certifssl.key -out /etc/ssl/certifssl.csr \
	&& openssl x509 -req -in /etc/ssl/certifssl.csr -signkey /etc/ssl/certifssl.key -out /etc/ssl/certifssl.crt -days 999

EXPOSE 80
EXPOSE 443

ADD ./srcs/nginx.conf /etc/nginx/conf.d/
ADD ./srcs/index.html /var/www/html/
COPY ./srcs/init.sh .
COPY ./srcs/proxy_params /etc/nginx/

CMD sh init.sh
