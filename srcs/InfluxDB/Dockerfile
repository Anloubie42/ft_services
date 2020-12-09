FROM alpine:3.11

RUN apk update && \
	apk upgrade && \
	apk add influxdb

RUN rm /etc/influxdb.conf

COPY ./srcs/influxdb.conf /etc/
COPY ./srcs/init.sh .

ENTRYPOINT ["sh", "/init.sh"]