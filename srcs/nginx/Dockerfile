from alpine:3.12

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl \
	&& apk add openssh

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
