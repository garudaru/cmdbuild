#!/bin/sh

echo "CONFIG SHARK ..."
POSTGRES_URL="$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB" 
CMDBUILD_URL="$CMDBUILD_HOST:$CMDBUILD_PORT/$CMDBUILD_APP_NAME" 

sed -i "s!org.cmdbuild.ws.url=.*!org.cmdbuild.ws.url=http\:\/\/$CMDBUILD_URL!g" $CATALINA_HOME/webapps/shark/conf/Shark.conf 
sed -i "s!url=.*!url=\"jdbc:postgresql\:\/\/$POSTGRES_URL\"!g" $CATALINA_HOME/webapps/shark/META-INF/context.xml 
