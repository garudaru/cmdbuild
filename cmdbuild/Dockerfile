FROM tomcat:9.0.31-jdk11-openjdk
MAINTAINER garudaru <garudaru@gmail.com>

WORKDIR $CATALINA_HOME

ARG CMDBUILD_NAME=cmdbuild

ENV CMDBUILD_REPORTS="additional-report-libs-1.5" \
    WEBAPPCMDBUILD="$CATALINA_HOME/webapps/$CMDBUILD_NAME" \
    CONFCMDBUILD="$CATALINA_HOME/conf/$CMDBUILD_NAME" \
    CMDBUILD_VERSION="3.3.2" \
    CMDBUILD_START_DIR="/opt/cmdbuild" \
    XBEAN_URL="http://archive.apache.org/dist/xml/xmlbeans/binaries/incubated-xmlbeans-1.0.0.zip"

ARG CMDBUILD_GET_URL="http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/$CMDBUILD_NAME-$CMDBUILD_VERSION.war" 
#ARG CMDBUILD_REPORTS_URL="http://downloads.sourceforge.net/project/cmdbuild/$CMDBUILD_VERSION/$CMDBUILD_REPORTS.zip" 

RUN date
RUN apt-get update \
	&& apt-get install -y --no-install-recommends postgresql-client \
        && rm -rf /var/lib/apt/lists/* \
        && apt-get -qy autoremove

RUN set -x \
	&& mkdir $CONFCMDBUILD \
        && groupadd tomcat \
	&& useradd -s /bin/false -g tomcat -d $CATALINA_HOME tomcat \
	&& wget -O /tmp/$CMDBUILD_NAME.war "$CMDBUILD_GET_URL" \
	&& cd /tmp \
	&& mkdir $WEBAPPCMDBUILD \
	&& unzip $CMDBUILD_NAME.war  -d $WEBAPPCMDBUILD\
        && chmod a+x $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh \
        && chown tomcat -R $CATALINA_HOME \
	&& rm $CMDBUILD_NAME.war \
	&& rm -rf /tmp/* \
	&& mkdir -p $CMDBUILD_START_DIR


COPY ./opt/cmdbuild $CMDBUILD_START_DIR

# Download wait-for-it
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh $CMDBUILD_START_DIR/wait-for-it.sh

RUN  set -x \
     && chmod a+x $CMDBUILD_START_DIR/creatdb.sh \
     && chmod a+rx $CMDBUILD_START_DIR/wait-for-it.sh  \
     && chmod a+rx $CMDBUILD_START_DIR/config-cmdbuild.sh  \
     && chmod a+x $CMDBUILD_START_DIR/start.sh 

ENV  CMDBUILD_DB_TYPE="MANUAL" \
     POSTGRES_USER="postgres" \
     POSTGRES_DB="cmdbuild" \
     CMDBUILD_ADMIN_USERNAME="cmdbuild" \
     CMDBUILD_ADMIN_USERNAME="cmdbuild" \
     POSTGRES_HOST="cmdbuild_db" \
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


VOLUME ["$CONFCMDBUILD", "$WEBAPPCMDBUILD/upload"]
#VOLUME ["$WEBAPPCMDBUILD/WEB-INF/conf", "$WEBAPPCMDBUILD/upload"]
EXPOSE 8080

ENTRYPOINT ["/opt/cmdbuild/start.sh"]
#ENTRYPOINT /opt/cmdbuild/start.sh

USER tomcat

CMD ["catalina.sh", "run"]
