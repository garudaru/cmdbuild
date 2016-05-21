#!/bin/sh

if [ $CMDBUILD_DB_TYPE != "MANUAL" ]
then
  POSTGRES_URL="$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB" 

  sed '/^\w*#/d' $WEBAPPCMDBUILD/WEB-INF/conf/database.conf  | grep "db.url" | grep $POSTGRES_URL 
  RETVAL="$?"

  echo "RETVAL: $RETVAL"

  if [ $RETVAL -eq 1 ] 
  then
    echo "CONFIGURING DB ..."
    echo "#" >$WEBAPPCMDBUILD/WEB-INF/conf/database.conf 
    echo -e "# `date`\n" >>$WEBAPPCMDBUILD/WEB-INF/conf/database.conf 
    echo "" >>$WEBAPPCMDBUILD/WEB-INF/conf/database.conf
    echo "db.url=jdbc\:postgresql\://$POSTGRES_URL" >>$WEBAPPCMDBUILD/WEB-INF/conf/database.conf
    echo "db.username=$POSTGRES_USER" >>$WEBAPPCMDBUILD/WEB-INF/conf/database.conf
    echo "db.password=$POSTGRES_PASSWORD">>$WEBAPPCMDBUILD/WEB-INF/conf/database.conf
  fi
fi


