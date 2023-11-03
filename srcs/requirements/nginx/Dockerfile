FROM debian:bullseye-slim

#RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";"
RUN apt-get update && \
    apt-get install -y nginx openssl dumb-init

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]
