FROM alpine:3.17

RUN apk update && apk upgrade && apk add nginx && mkdir -p /var/www/html/

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/http.d/default.conf

RUN apk add openssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE/ST=LowerSax/L=Wolfsburg/O=42/OU=42WOB/CN=nginx"

RUN adduser -D -g 'www' www && chown -R www:www /run/nginx/ && chown -R www:www /var/www/html/

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

