from alpine:3.11

RUN apk update && \
	apk add mysql mysql-client && \
	mkdir -p /auth_pam_tool_dir/auth_pam_tool && \
	mkdir -p /run/mysqld && \
	rm /etc/my.cnf

COPY ./srcs/init.sh .
COPY ./srcs/admin.sql .
ADD ./srcs/my.cnf /etc/
ADD ./srcs/my.cnf /etc/mysql/

CMD sh init.sh