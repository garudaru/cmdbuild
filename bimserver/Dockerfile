FROM garudaru/tomcat
MAINTAINER garudaru <garudaru@gmail.com>

#ARG BIMSERVER_URL=https://github.com/opensourceBIM/BIMserver/releases/download/parent-1.5.43/bimserverwar-1.5.43.war
#ARG BIMSERVER_URL=http://github.com/opensourceBIM/BIMserver/releases/download/1.4.0-FINAL-2015-11-04/bimserver-1.4.0-FINAL-2015-11-04.war
ARG BIMSERVER_URL=http://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bimserver/bimserver-1.2.war

##ADD $BIMSERVER_URL /usr/local/tomcat/webapps/bimserver.war
#COPY ./bimserver-1.2.war /usr/local/tomcat/webapps/bimserver.war
#WORKDIR /usr/local/tomcat/webapps/
#RUN  mkdir bimserver && unzip bimserver.war -d bimserver && rm bimserver.war

RUN  set -x \
    && apk --no-cache --update add wget \
    && wget --no-check-certificate -O /usr/local/tomcat/webapps/bimserver.war  $BIMSERVER_URL \
    && mkdir /usr/local/tomcat/webapps/bimserver \
    && unzip /usr/local/tomcat/webapps/bimserver.war -d /usr/local/tomcat/webapps/bimserver \
    && rm /usr/local/tomcat/webapps/bimserver.war \
    && apk --no-cache del wget


