#!/bin/bash
export MQCCDTURL=ccdt.json
export MQSSLKEYR=../certs/mqclient

# amqsputc APPQ QM1

i=1
while [ $i -le 10 ]
do
    printf "%s\n\n" "sending message $i to queue manager" | amqsputc APPQ QM1 > /dev/null
    echo "Sending message $i to queue manager"
    (( i++ ))
done

