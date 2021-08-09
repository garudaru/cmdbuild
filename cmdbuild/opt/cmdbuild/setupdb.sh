#!/bin/sh

if [ $CMDBUILD_DB_TYPE != "MANUAL" ]
then
  POSTGRES_URL="$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB" 

  sed '/^\w*#/d' $CONFCMDBUILD/database.conf  | grep "db.url" | grep $POSTGRES_URL 
  RETVAL="$?"

  echo "RETVAL: $RETVAL"

  if [ $RETVAL -eq 1 ] 
  then
    echo "CONFIGURING DB ..."
    echo "#" >$CONFCMDBUILD/database.conf 
    echo "# `date`\n" >>$CONFCMDBUILD/database.conf 
    echo "" >>$CONFCMDBUILD/database.conf
    echo "db.url=jdbc\:postgresql\://$POSTGRES_URL" >>$CONFCMDBUILD/database.conf
    echo "db.username=$CMDBUILD_ADMIN_USERNAME" >>$CONFCMDBUILD/database.conf
    echo "db.password=$CMDBUILD_ADMIN_PASSWORD" >>$CONFCMDBUILD/database.conf
#    echo "db.username=cmdbuild" >>$CONFCMDBUILD/database.conf
#    echo "db.password=cmdbuild" >>$CONFCMDBUILD/database.conf
    echo "db.admin.username=$POSTGRES_USER" >>$CONFCMDBUILD/database.conf
    echo "db.admin.password=$POSTGRES_PASSWORD">>$CONFCMDBUILD/database.conf
  fi
fi


