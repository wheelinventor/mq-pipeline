#!/bin/bash
channel_name=${1:-QM1CHL}
queue_name=${2:-APPQ}
release_name=${3:-qm1}
namespace=${4:-mq}
mq_host=$(oc get pod qm-native-mqsc-dersx-ibm-mq-0 -n mq --template '{{.status.podIP}}')

## generate yaml
( echo "cat <<EOF" ; cat ./config/testing-job.yaml.tmpl; echo EOF ) | \
mq_host=${mq_host} \
channel_name=${channel_name} \
queue_name=${queue_name} \
sh > ./config/testing-job.yaml

cat ./config/testing-job.yaml