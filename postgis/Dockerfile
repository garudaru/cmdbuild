FROM suquant/postgisd
MAINTAINER garudaru <garudaru@gmail.com>

COPY . /
RUN chmod a+x /docker-entrypoint-initdb.d/initdb-postgis.sh \
    && chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postgres"]
