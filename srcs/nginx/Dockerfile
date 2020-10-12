from alpine:3.11

RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& adduser -D -g 'www' www \
	&& mkdir /www \
	&& chown -R www:www /var/lib/nginx \
	&& chown -R www:www /www \
	&& apk add openrc --no-cache \
	&& mkdir /run/nginx \
	&& touch /run/nginx/nginx.pid \
	&& rm /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

ADD ./srcs/nginx.conf /etc/nginx/conf.d/
COPY ./srcs/init.sh .

CMD sh init.sh
