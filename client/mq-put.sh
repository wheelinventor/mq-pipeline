#!/bin/bash
export MQCCDTURL=ccdt.json
export MQSSLKEYR=../certs/mqclient

i=0
while [ $i -le 1000 ]
do
    (( i++ ))
    printf "%s\n\n" "sending message $i to queue manager" | amqsputc APPQ QM1 > /dev/null
    echo "Sending message $i to queue manager"
done

