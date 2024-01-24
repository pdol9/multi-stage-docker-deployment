FROM alpine:3.17

RUN apk update && apk upgrade && apk add mariadb mariadb-client

COPY ./tools/db_setup.sh /tmp/db_setup.sh
RUN chmod +x /tmp/db_setup.sh

ENTRYPOINT [ "sh", "/tmp/db_setup.sh" ]

