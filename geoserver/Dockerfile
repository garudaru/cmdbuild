# anohter winsent/geoserver-alpine
#FROM tomcat:8-jre7 
FROM garudaru/tomcat
MAINTAINER garudaru <garudaru@gmail.com>

ENV GEOSERVER_DATA_DIR /opt/geoserver/data_dir 

#ENV GEOSERVER_URL http://sourceforge.net/projects/geoserver/files/GeoServer/2.9-RC1/geoserver-2.9-RC1-war.zip
ENV GEOSERVER_URL http://build.geonode.org/geoserver/latest/geoserver.war

RUN  set -x \
    && apk --no-cache --update add wget \
    && wget --no-check-certificate $GEOSERVER_URL -O /usr/local/tomcat/webapps/geoserver.war  \
    && mkdir $CATALINA_HOME/webapps/geoserver \
    && unzip $CATALINA_HOME/webapps/geoserver.war -d /usr/local/tomcat/webapps/geoserver \
    && rm -rf $CATALINA_HOME/webapps/geoserver/data/workspaces/* \    
    && rm /usr/local/tomcat/webapps/geoserver.war \    
    && apk --no-cache del wget

COPY ./workspaces/ $CATALINA_HOME/webapps/geoserver/data/workspaces/
VOLUME $CATALINA_HOME/webapps/geoserver/data