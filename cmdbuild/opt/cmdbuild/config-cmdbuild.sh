echo "WAIT TOMCAT ..."

$CMDBUILD_START_DIR/wait-for-it.sh -t 30 localhost:8080 
WAITFORIT_RESULT=$?

if [[ $WAITFORIT_RESULT  -eq  0 ]] 
then
  echo "START UP ..."
#  sleep 30;

  until [ "$(curl -w '%{response_code}' --no-keepalive -o /dev/null --connect-timeout 1 -s -L -u USERNAME:PASSWORD http://localhost:8080/cmdbuild)" == "200" ];
  do echo --- sleeping for 1 second;
  sleep 1;
  done

  whoami
    for f in $CMDBUILD_START_DIR/*; do
        case "$f" in
            */setupdb.sh)  echo "$0: ignoring $f" ;;
            */setup*.sh)  echo "$0: running $f"; sh "$f" ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done
fi
