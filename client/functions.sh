#!/bin/bash

function wait_for () {
  OBJ_NAME=${1}
  OBJ_TYPE=${2}
  OBJ_NAMESPACE=${3}
  OBJ_READY_STATUS=$4

  echo "Waiting for [${OBJ_NAME}] of type [${OBJ_TYPE}] in namespace [${OBJ_NAMESPACE}] to be in [${OBJ_READY_STATUS}] status"

  INITIAL_SLEEP_TIME="60"
  SLEEP_TIME="60"
  RUN_LIMIT=200
  i=0

  echo "Waiting $INITIAL_SLEEP_TIME seconds for initialization"
  sleep $INITIAL_SLEEP_TIME

  while true; do

    if ! STATUS=$(oc get ${OBJ_TYPE} -n ${OBJ_NAMESPACE} ${OBJ_NAME} -ojson | jq -c -r '.status.phase'); then
      echo 'Error getting status'
      exit 1
    fi
    echo "Installation status: $STATUS"
    if [ "$STATUS" == ${OBJ_READY_STATUS} ]; then
      sleep 30
      break
    fi
    
    if [ "$STATUS" == "Failed" ]; then
      echo '=== Installation has failed ==='
      exit 1
    fi
    
    echo "Sleeping $SLEEP_TIME seconds..."
    sleep $SLEEP_TIME
    
    (( i++ ))
    if [ "$i" -eq "$RUN_LIMIT" ]; then
      echo 'Timed out'
      exit 1
    fi
  done
}