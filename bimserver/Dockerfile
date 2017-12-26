FROM tomcat:8-jre8-alpine
MAINTAINER garudaru <garudaru@gmail.com>

ARG  BIMSERVER=1.5.90 
ARG  BIMSERVER_URL=https://github.com/opensourceBIM/BIMserver/releases/download/parent-$BIMSERVER/bimserverwar-$BIMSERVER.war
RUN  set -x \
    && cd  /usr/local/tomcat/webapps \
    && rm -rf * \
    && wget -O /usr/local/tomcat/webapps/bimserver.war  $BIMSERVER_URL \
    && mkdir /usr/local/tomcat/webapps/ROOT \
    && unzip /usr/local/tomcat/webapps/bimserver.war -d /usr/local/tomcat/webapps/ROOT \
    && rm /usr/local/tomcat/webapps/bimserver.war 

COPY ./default.policy /usr/local/tomcat/conf/default.policy
COPY ./server.xml /usr/local/tomcat/conf/server.xml
COPY ./context.xml /usr/local/tomcat/conf/context.xml

VOLUME ["/bimhomedir"]
ADD ./bimhomedir.tar.gz /bimhomedir/
EXPOSE 8080
