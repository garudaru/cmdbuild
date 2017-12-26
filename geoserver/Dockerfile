FROM tomcat:8-jre8-alpine
MAINTAINER garudaru <garudaru@gmail.com>

ENV GEOSERVER_DATA_DIR /opt/geoserver/data_dir 

ARG GEOSERVER_URL=http://build.geonode.org/geoserver/latest/geoserver.war

RUN  set -x \
    && wget $GEOSERVER_URL -O /usr/local/tomcat/webapps/geoserver.war  \
    && mkdir $CATALINA_HOME/webapps/geoserver \
    && unzip $CATALINA_HOME/webapps/geoserver.war -d /usr/local/tomcat/webapps/geoserver \
    && rm -rf $CATALINA_HOME/webapps/geoserver/data/workspaces/* \    
    && rm /usr/local/tomcat/webapps/geoserver.war 

COPY ./workspaces/ $CATALINA_HOME/webapps/geoserver/data/workspaces/
VOLUME $CATALINA_HOME/webapps/geoserver/data
EXPOSE 8080
