from alpine:3.11

RUN apk update && \
    apk add mysql mysql-client

COPY ./srcs/init.sh .

CMD sh init.sh