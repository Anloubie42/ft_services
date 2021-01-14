from alpine:3.11

RUN apk update && \
	apk upgrade && \
	apk add wget busybox && \
	apk add --no-cache libc6-compat

RUN mkdir -p /usr/share/webapps

COPY ./srcs/grafana-7.3.6.linux-amd64.tar.gz /

# RUN wget https://dl.grafana.com/oss/release/grafana-7.3.6.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.3.6.linux-amd64.tar.gz

RUN mv grafana-7.3.6 grafana && \
	mv grafana /usr/share/webapps

COPY ./srcs/init.sh .
COPY ./srcs/grafana.db /usr/share/webapps/grafana/data/

ENTRYPOINT ["sh", "/init.sh"]