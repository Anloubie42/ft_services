from alpine:3.11

RUN apk update && \
	apk upgrade

RUN apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

# RUN rm /usr/share/grafana/data/grafana.db

COPY ./srcs/init.sh .
COPY ./srcs/grafana.db /usr/share/grafana/data/

ENTRYPOINT ["sh", "/init.sh"]