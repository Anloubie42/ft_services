from alpine:3.11

RUN apk update && \
    apk add mysql mysql-client && \
    mkdir -p /auth_pam_tool_dir/auth_pam_tool && \
    mkdir -p /run/mysqld

COPY ./srcs/init.sh .
COPY ./srcs/admin.sql .

CMD sh init.sh