#!/bin/sh

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

echo "START UP ..."
sh $CMDBUILD_START_DIR/creatdb.sh
#sh $CMDBUILD_START_DIR/setupdb.sh
#sh $CMDBUILD_START_DIR/setupldap.sh

    for f in $CMDBUILD_START_DIR/*; do
        case "$f" in
            */setup*.sh)  echo "$0: running $f"; . "$f" ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done


echo "RUN CMDBUILD ..."
"$@"

