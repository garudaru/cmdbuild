# webcenter/rancher-alfresco

FROM quay.io/webcenter/rancher-base-image:latest
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

#Alfresco version
ENV ALF_URL=http://dl.alfresco.com/release/community/201602-build-00005/alfresco-community-installer-201602-linux-x64.bin
ENV ALF_HOME=/opt/alfresco


RUN mkdir -p /app/assets

# install alfresco
COPY assets/setup/install_alfresco.sh /app/assets/install_alfresco.sh
RUN chmod +x /app/assets/install_alfresco.sh
RUN /app/assets/install_alfresco.sh

# install mysql connector for alfresco
COPY assets/setup/install_mysql_connector.sh /app/assets/install_mysql_connector.sh
RUN chmod +x /app/assets/install_mysql_connector.sh
RUN /app/assets/install_mysql_connector.sh


# this is for LDAP configuration
RUN mkdir -p ${ALF_HOME}/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap/ldap1/
COPY assets/setup/ldap-authentication.properties ${ALF_HOME}/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap/ldap1/ldap-authentication.properties


# init scripts
COPY assets/init.py /app/
COPY assets/run.sh /app/
RUN chmod +x /app/*
COPY assets/setup/supervisord-alfresco.conf /etc/supervisor/conf.d/
COPY assets/setup/supervisord-postgresql.conf /etc/supervisor/conf.d/

# CLEAN APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["${ALF_HOME}/alf_data", "${ALF_HOME}/tomcat/logs"]

EXPOSE 21 137 138 139 445 7070 8009 8080


CMD /app/run.sh

