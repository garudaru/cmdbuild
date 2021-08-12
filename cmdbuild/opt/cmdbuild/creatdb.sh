#!/bin/bash
      
export PGPASSWORD="$POSTGRES_PASSWORD"
SQLPATH="$WEBAPPCMDBUILD/WEB-INF/sql"
PATCHPATH="$WEBAPPCMDBUILD/WEB-INF"
echo "PGPASSWORD: $PGPASSWORD"
export POSTGRES="psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER "

echo "CMDBUILD_DB_TYPE: $CMDBUILD_DB_TYPE"

RETN_CODE=0

if [ $CMDBUILD_DB_TYPE = "MANUAL" ]
then
 echo "CMDBUILD MANUAL";
elif $POSTGRES -d $POSTGRES_DB -lqt | cut -d \| -f 1 | grep -qw $POSTGRES_DB; then
 echo "$POSTGRES_DB database exists";
 echo "CONFIG MODE is $CONFIG_MODE";
 if [ "$CONFIG_MODE" = "FIRSTRUN" ]
 then
   echo "******** NO CONFIG RUNNING. USE SEIINGS FFROM DATABASE ********"
   RETN_CODE=113
 fi
else

echo  "CMDBUILD create database"
unset PGPASSWORD

if [ "$CMDBUILD_DUMPNODATABASE" = "NODATABASE" ]
then
  if [ $CMDBUILD_DB_TYPE = "DEMO" ]
  then
    export CMDBUILD_DUMP="demo"
  elif [ $CMDBUILD_DB_TYPE = "EMPTY" ]
  then
    export CMDBUILD_DUMP="empty"
  fi
fi

echo "Init DB"
{ # try

    echo "----------------------------------------------------------------"
    env
    echo "----------------------------------------------------------------"
    cat $CATALINA_HOME/conf/cmdbuild/database.conf
    echo "----------------------------------------------------------------"
    echo `whoami`
    echo "----------------------------------------------------------------"
    echo "$CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create $CMDBUILD_DUMP -configfile $CATALINA_HOME/conf/cmdbuild/database.conf"
    echo "----------------------------------------------------------------"
    bash $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig create $CMDBUILD_DUMP -configfile $CATALINA_HOME/conf/cmdbuild/database.conf
#    bash $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh dbconfig recreate $CMDBUILD_DUMP -configfile $CATALINA_HOME/conf/cmdbuild/database.conf
   
} || { 
    echo "DB was initiliazed. Use dbconfig recreate or dbconfig drop"
}

fi






















