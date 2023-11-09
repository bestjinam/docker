FROM debian:bullseye-slim


RUN apt-get update && \
    apt-get install -y mariadb-server dumb-init

COPY  --chmod=777 ./conf/my.cnf /etc/mysql/my.cnf
COPY  --chmod=777 ./tools/docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]
