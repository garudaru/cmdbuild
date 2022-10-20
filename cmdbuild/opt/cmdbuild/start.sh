#!/bin/bash
set -e

echo "WAITING DATABASE ..."
echo ">> Waiting for postgres to start"
export PGPASSWORD="$POSTGRES_PASSWORD"
WAIT=0

while ! psql -l -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER; do
  sleep 1
  echo  "CMDBUILD SLEEP  : $WAIT"
  WAIT=$(($WAIT + 1))
  if [ "$WAIT" -gt 15 ]; then
    echo "Error: Timeout wating for Postgres to start"
    exit 1
  fi
done

$CMDBUILD_START_DIR/setupdb.sh
source $CMDBUILD_START_DIR/creatdb.sh
echo "RETN CODE: $RETN_CODE"

echo "***  RUN CONFIG SETTINGS ****"
$CMDBUILD_START_DIR/config-cmdbuild.sh $RETN_CODE &

echo "RUN CMDBUILD ..."
#echo "Change user to tomcat"
#su tomcat

"$@"
