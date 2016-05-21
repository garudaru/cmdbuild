#!/bin/sh
      
export PGPASSWORD="$POSTGRES_PASSWORD"
SQLPATH="$WEBAPPCMDBUILD/WEB-INF/sql"
PATCHPATH="$WEBAPPCMDBUILD/WEB-INF"
echo "PGPASSWORD: $PGPASSWORD"
export POSTGRES="psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER "


if [ $CMDBUILD_DB_TYPE = "MANUAL" ]
then
 echo "CMDBUILD MANUAL";
elif $POSTGRES -d $POSTGRES_DB -lqt | cut -d \| -f 1 | grep -qw $POSTGRES_DB; then
 echo "$POSTGRES_DB database exists";
else

$POSTGRES  <<EOSQL1
CREATE DATABASE $POSTGRES_DB TEMPLATE template_postgis;
alter database $POSTGRES_DB set search_path="\$usr", public,gis, topology;
EOSQL1

echo  "CMDBUILD create database : $?"

#$POSTGRES -d $POSTGRES_DB  <<EOSQL1
#create schema gis;
#grant all on schema gis to public;
#create extension postgis with schema gis;
#CREATE EXTENSION postgis_topology;
#alter database $POSTGRES_DB set search_path="\$usr", public,gis, topology;
#EOSQL1


if [ $CMDBUILD_DB_TYPE = "DEMO" ]
then
  $POSTGRES -d $POSTGRES_DB -f $SQLPATH/sample_schemas/demo_schema.sql
  echo  "CMDBUILD DEMO FILL database : $?"
elif [ $CMDBUILD_DB_TYPE = "EMPTY" ]
then
  for f in $SQLPATH/base_schema/*; do 
   case "$f" in 
     *.sql)    echo "$0: running $f"; $POSTGRES -d $POSTGRES_DB -f $f; echo ;; 
     *)        echo "$0: ignoring $f" ;; 
   esac 
   echo 
  done 
PATCHVER=`ls $PATCHPATH/patches | tail - -n 1 / sed -e 's/\([0-9\.]*\)-.*\.sql/\1/g'`
echo  "PATCH: $PATCHVER"
$POSTGRES -d $POSTGRES_DB <<EOSQL1
SELECT cm_create_class('Patch', 'Class', 'DESCR: |MODE: reserved|STATUS: active|SUPERCLASS: false| TYPE: class'); INSERT INTO "Patch" ("Code") VALUES ('$PATCHVER'); 
EOSQL1

$POSTGRES -d $POSTGRES_DB <<EOSQL1
INSERT INTO "User" ("Status", "Username", "IdClass", "Password", "Description") VALUES ('A', 'admin', '"User"', 'DQdKW32Mlms=', 'Administrator'); 
INSERT INTO "Role" ("Status", "IdClass", "Administrator", "Code", "Description") VALUES ('A', '"Role"', true, 'SuperUser', 'SuperUser'); 
INSERT INTO "Map_UserRole" ("Status", "IdClass1", "IdClass2", "IdObj1", "IdObj2", "IdDomain") VALUES ('A', '"User"'::regclass,'"Role"'::regclass, currval('class_seq')-2, currval('class_seq'), '"Map_UserRole"'::regclass);
EOSQL1
fi

# init Shark schema
$POSTGRES -d $POSTGRES_DB <<EOSQL1
CREATE SCHEMA shark AUTHORIZATION postgres;
CREATE ROLE shark LOGIN
ENCRYPTED PASSWORD 'md5088dfc423ab6e29229aeed8eea5ad290'
NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;
ALTER ROLE shark SET search_path=pg_default,shark; 
GRANT ALL ON SCHEMA shark TO shark;
GRANT ALL ON SCHEMA shark TO postgres;
EOSQL1

echo  "CMDBUILD SHARK schema : $?"


#psql -h pgsql -U $POSTGRES_USER  -d $POSTGRES_DB -f $SQLPATH/shark_schema/01_shark_user.sql

export PGPASSWORD="shark"
export POSTGRES_USER="shark" 
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB -f $SQLPATH/shark_schema/02_shark_emptydb.sql
echo  "CMDBUILD SHARK create database : $?"

fi






















