FROM tomcat:8-jre8-alpine
MAINTAINER garudaru <garudaru@gmail.com>

ENV CMDBUILD_VERSION="2.5.0" \ 
    LIB="http://jdbc.postgresql.org/download/postgresql-9.4.1208.jar"

ARG CMDBUILD_SHARK_URL="http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/shark-cmdbuild-$CMDBUILD_VERSION.zip"

RUN set -x \
        && apk --no-cache --update add postgresql-client \
        && cd /tmp/ \
        && busybox wget -P "$CATALINA_HOME/lib/" "$LIB" \
        && busybox wget -O /tmp/shark.zip "$CMDBUILD_SHARK_URL" \
        && unzip shark.zip  \
        && rm -rf shark.zip \
        && mv shark* shark \
        && cd /tmp/shark/ \
        && mkdir temp \
        && mv *.war temp/ \
        && cd temp \
        && mv cmdbuild-shark*.war shark.war \
        && mkdir $CATALINA_HOME/webapps/shark \
        && unzip shark.war -d $CATALINA_HOME/webapps/shark \
	&& rm -rf * /tmp/* 

COPY ./opt/ /opt/
RUN set -x \
   && chmod a+x /opt/cmdbuild/config.sh \
   && chmod a+x /opt/cmdbuild/start.sh

ENV CMDBUILD_HOST="cmdbuild" \
  CMDBUILD_PORT="8080" \
  CMDBUILD_APP_NAME="cmdbuild" \
  POSTGRES_USER="postgres" \
  POSTGRES_DB="cmdbuild" \
  POSTGRES_HOST="pgsql" \
  POSTGRES_PORT="5432" \
  POSTGRES_PASSWORD="postgres" 

EXPOSE 8080
ENTRYPOINT ["/opt/cmdbuild/start.sh"]
CMD ["catalina.sh", "run"]
