#FROM java:8-jre
#FROM develar/java
FROM frolvlad/alpine-oraclejdk8:slim 
MAINTAINER garudaru <garudaru@gmail.com>

ENV CATALINA_HOME="/usr/local/tomcat" \
    TOMCAT_MAJOR="7" \
    TOMCAT_VERSION="7.0.69" \ 
    CMDBUILD_VERSION="2.4.0" 

ENV PATH="$CATALINA_HOME/bin:$PATH" \
    TOMCAT_TGZ_URL="http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz"
#    TOMCAT_TGZ_URL="http://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz"

WORKDIR $CATALINA_HOME
RUN set -x \
        && wget "$TOMCAT_TGZ_URL" -P $CATALINA_HOME/ \
	&& tar -xzf apache-tomcat-$TOMCAT_VERSION.tar.gz \
	&& mv apache-tomcat-$TOMCAT_VERSION/* ./ \
	&& rm -rf apache-tomcat-$TOMCAT_VERSION.tar.gz \
	&& rm -rf apache-tomcat-$TOMCAT_VERSION/ \
	&& rm -rf ./webapps/* 

EXPOSE 8080
ENTRYPOINT ["catalina.sh"]
CMD ["run"]
