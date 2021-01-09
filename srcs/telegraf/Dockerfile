FROM alpine:3.11

RUN apk update && \
	apk upgrade && \
	apk add wget && \
	apk add sudo && \
	apk add --no-cache libc6-compat

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.16.1_linux_i386.tar.gz && \
	tar xf telegraf-1.16.1_linux_i386.tar.gz && \
	mv telegraf-1.16.1 telegraf && \
	mv telegraf /home

RUN touch /var/run/utmp

COPY ./srcs/init.sh /
COPY ./srcs/telegraf.conf /etc/

EXPOSE 35000

CMD sh init.sh