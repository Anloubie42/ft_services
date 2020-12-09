FROM alpine:3.11

RUN apk update && \
	apk upgrade

RUN apk add telegraf --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN mkdir -p /home/telegraf
RUN rm /etc/telegraf.conf

COPY ./srcs/init.sh /
COPY ./srcs/telegraf.conf /etc/

CMD sh init.sh