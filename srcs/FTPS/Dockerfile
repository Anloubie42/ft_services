from alpine:3.11

RUN apk update && \
	apk upgrade && \
	apk add vsftpd openssl

RUN echo "root:root" | chpasswd
RUN touch /home/test

RUN rm /etc/vsftpd/vsftpd.conf
RUN mkdir -p /etc/certs/

RUN openssl req -new -x509 -days 365 -nodes -out /etc/ssl/private/vsftp.cert.pem \
-keyout /etc/ssl/private/vsftpd.key.pem -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=ft_services.com"

EXPOSE 21 20 30020-30024

COPY ./srcs/init.sh .
COPY ./srcs/vsftpd.conf /etc/vsftpd

# CMD sh init.sh
ENTRYPOINT ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
