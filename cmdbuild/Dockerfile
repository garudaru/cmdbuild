FROM garudaru/tomcat
MAINTAINER garudaru <garudaru@gmail.com>

ARG CMDBUILD_NAME=cmdbuild

ENV CMDBUILD_REPORTS="additional-report-libs-1.5" \
    WEBAPPCMDBUILD="$CATALINA_HOME/webapps/$CMDBUILD_NAME/" \
    CMDBUILD_VERSION="2.4.2" 

ENV CMDBUILD_START_DIR="/opt/cmdbuild" \
    CMDBUILD_GET_URL="http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/cmdbuild-$CMDBUILD_VERSION.zip" \
    CMDBUILD_REPORTS_URL="http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/$CMDBUILD_REPORTS.zip" \
    LIB="http://jdbc.postgresql.org/download/postgresql-9.4.1208.jar" 

RUN set -x \
	&& wget "$CMDBUILD_GET_URL" -O /tmp/cmdbuild.zip \
	&& cd /tmp \
	&& unzip cmdbuild.zip \
	&& rm -rf cmdbuild.zip \
	&& mv cmdbuild* cmdbuild \
	&& cd /tmp/cmdbuild/ \
	&& mv cmdbuild*.war $CMDBUILD_NAME.war \
	&& mkdir $WEBAPPCMDBUILD \
	&& unzip $CMDBUILD_NAME.war  -d $WEBAPPCMDBUILD\
	&& rm $CMDBUILD_NAME.war \
	&& cd /tmp \
	&& rm -rf /tmp/* \
	&& wget "$CMDBUILD_REPORTS_URL"  -P /tmp/ \
        && unzip "$CMDBUILD_REPORTS.zip" \
        && mv $CMDBUILD_REPORTS/* $CATALINA_HOME/lib/ \
	&& rm -rf /tmp/* \
        && apk --no-cache --update add postgresql-client \
	&& mkdir -p $CMDBUILD_START_DIR

COPY ./opt/cmdbuild $CMDBUILD_START_DIR
RUN  set -x \
     && chmod a+x $CMDBUILD_START_DIR/creatdb.sh \
     && chmod a+x $CMDBUILD_START_DIR/start.sh

ENV  CMDBUILD_DB_TYPE="MANUAL" \
     POSTGRES_USER="postgres" \
     POSTGRES_DB="cmdbuild" \
     POSTGRES_HOST="pgsql" \
     POSTGRES_PORT="5432" \
     POSTGRES_PASSWORD="postgres" \
     AUTH_LDAP_SERVER_PORT="389" \
     AUTH_LDAP_USE_SSL="false" \
     AUTH_METHOD="DBAuthenticator" \
     EMAIL_QUEUE_ENABLED="false" \
     EMAIL_QUEUE_TIME="0" \
     CMDBF_MDRID="http://www.cmdbuild.org" \
     CMDBF_SCHEMALOCATION="http://localhost:8080/cmdbuild/services/cmdb-schema" \
     BIM_ENABLED="false" \
     SHARK_ENABLED="false" \
     GIS_ENABLED="false" 


ADD  $LIB $CATALINA_HOME/lib
WORKDIR $CATALINA_HOME

VOLUME ["$WEBAPPCMDBUILD/WEB-INF/conf", "$WEBAPPCMDBUILD/upload"]
EXPOSE 8080

ENTRYPOINT ["/opt/cmdbuild/start.sh"]
CMD ["catalina.sh", "run"]
