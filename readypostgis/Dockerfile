FROM suquant/postgisd
MAINTAINER garudaru <garudaru@gmail.com>

COPY . /
RUN chmod a+x /docker-entrypoint-initdb.d/initdb-postgis.sh \
    && chmod a+x /docker-entrypoint.sh

ENV READY_DB_TYPE="DEMO" \
    POSTGRES_DB="cmdbuild"

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]
