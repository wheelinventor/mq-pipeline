#!/bin/bash
channel_name=${1:-QM1CHL}
queue_name=${2:-APPQ}
release_name=${3:-qm1}
namespace=${4:-mq}
mq_host=$(oc get pod ${release_name}-ibm-mq-0 -n ${namespace} --template '{{.status.podIP}}')

## generate yaml
( echo "cat <<EOF" ; cat ./config/testing-job.yaml.tmpl; echo EOF ) | \
mq_host=${mq_host} \
release_name=${release_name} \
channel_name=${channel_name} \
queue_name=${queue_name} \
sh > ./config/testing-job.yaml

cat ./config/testing-job.yaml
sleep 30

## apply yaml file of job to run testing stub 
oc apply -f ./config/testing-job.yaml -n ${namespace}
sleep 30
oc logs job/mq-test-${release_name} -n ${namespace}