#!/bin/bash
DIR=`dirname "$0"`
source ${DIR}/functions.sh

export MQCCDTURL=ccdt.json
export MQSSLKEYR=../certs/mqclient

i=0
until wait_for ${release_name} QueueManager ${namespace} "Running"
do
    i++
    printf "%s\n\n" "sending message $i to queue manager" | amqsputc APPQ QM1 > /dev/null
    echo "Sending message $i to queue manager"
done



