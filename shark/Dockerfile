FROM garudaru/tomcat
MAINTAINER garudaru <garudaru@gmail.com>

ENV CMDBUILD_VERSION="2.4.2" \ 
    LIB="http://jdbc.postgresql.org/download/postgresql-9.4.1208.jar"

ENV CMDBUILD_SHARK_URL   http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/shark-cmdbuild-$CMDBUILD_VERSION.zip

#ADD $LIB $CATALINA_HOME/lib

RUN set -x \
#	&& mkdir /opt \
        && apk --no-cache --update add postgresql-client wget \
#        && cd /opt/ \
        && cd /tmp/ \
        && wget --no-check-certificate -P "$CATALINA_HOME/lib/" "$LIB" \
        && wget "$CMDBUILD_SHARK_URL" \
        && mv shark* shark.zip \
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
