from alpine:3.11

RUN apk update && \
	apk upgrade && \
	apk add vsftpd openssl

RUN echo "root:anloubie" | chpasswd

RUN rm /etc/vsftpd/vsftpd.conf
RUN mkdir -p /etc/certs/

RUN openssl req -new -x509 -days 365 -nodes -out /etc/certs/vstfpd.pem \
-keyout /etc/certs/vsftpd.pem -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=ft_services.com"

EXPOSE 21 20 30000-50000

COPY ./srcs/init.sh .
COPY ./srcs/vsftpd.conf /etc/vsftpd

CMD sh init.sh
