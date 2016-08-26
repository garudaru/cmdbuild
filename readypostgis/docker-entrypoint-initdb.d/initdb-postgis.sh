#!/bin/sh

echo on

export PGUSER=postgres
POSTGRES="gosu postgres"
POSTGRES_RESTORE="gosu pg_restore"
POSTGIS_DIR="/usr/share/postgresql/contrib/postgis-2.2"
export DBASE_NAME="$POSTGRES_DB"


# init Shark schema
$POSTGRES psql -d $POSTGRES_DB <<EOSQL1
CREATE ROLE shark LOGIN
ENCRYPTED PASSWORD 'md5088dfc423ab6e29229aeed8eea5ad290'
NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;
EOSQL1

echo  "CMDBUILD SHARK schema : $?"
echo  "READY DB TYPE         : $READY_DB_TYPE"

if [ $READY_DB_TYPE = "DEMO" ]
then 
  echo  " RESTORE DEMO READY DB TYPE "
  pg_restore -U $POSTGRES_USER -d $POSTGRES_DB --disable-triggers /docker-entrypoint-initdb.d/database.backup
else
  echo  "RESTORE EMPTY READY DB TYPE "
  pg_restore -U $POSTGRES_USER -d $POSTGRES_DB --disable-triggers /docker-entrypoint-initdb.d/database_empty.backup
fi
echo  "pg_restore : $?"
##pg_restore -U $POSTGRES_USER -h 127.0.0.1 -p 5432 -d $POSTGRES_DB --disable-triggers /docker-entrypoint-initdb.d/database.backup
