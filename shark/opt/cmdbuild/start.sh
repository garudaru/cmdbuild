#!/bin/sh

sh /opt/cmdbuild/config.sh

echo "WAITING DATABASE ..."
echo ">> Waiting for postgres to start"
export PGPASSWORD="$POSTGRES_PASSWORD"

WAIT=0

while ! psql -l -h $POSTGRES_HOST -U $POSTGRES_USER | grep $POSTGRES_DB; do
  sleep 1
  echo "SLEEP SHARK DB: $WAIT"  
  WAIT=$(($WAIT + 1))
  if [ "$WAIT" -gt 15 ]; then
    echo "Error: Timeout wating for database cmdbuild Postgres to start"
    exit 1
  fi
done

echo "START UP SHARK ..."

while ! psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB -c "SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'shark';" | grep "shark"; do
  sleep 1
  echo "SLEEP SHARK SCHEMA: $WAIT"  
  WAIT=$(($WAIT + 1))
  if [ "$WAIT" -gt 115 ]; then
    echo "Error: Timeout wating for shark schema Postgres to start"
    exit 1
  fi
done

echo "RUN SHARK ..."
"$@"

