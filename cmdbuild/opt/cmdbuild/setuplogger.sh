#!/bin/bash

#LOGGER_ENABLE=true
#declare -a LOG_LEVEL=(DEBUG INFO WARN)
#declare -a DEBUG_LOGGER=(debug.aaa debug.bbb debug.cc)
#declare -a INFO_LOGGER=(info.aaa info.bbb info.cc)
#declare -a WARN_LOGGER=(warn1 warn.2 warn3)

if [ "$LOGGER_ENABLE"=="true" ]
then
  $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws getloggers
  echo "LOG LEVEL ${LOGGER_LEVEL[@]}"
#  for level in "${LOGGER_LEVEL[@]}"; do
  IFS=' ' read -ra level_array <<< ${LOGGER_LEVEL[@]}
  for level in "${level_array[@]}"; do
    logger="${level}_LOGGER[@]"
#    for log in "${!logger}"; do
    IFS=' ' read -ra log_array <<< ${!logger}
    for log in "${log_array[@]}"; do
        echo "LOG: $log  LEVEL: $level"
        $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh restws setlogger ${log} ${level}
    done
  done
fi



