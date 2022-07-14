#!/bin/bash
channel_name=${1:-QM1CHL}
queue_name=${2:-APPQ}
release_name=${3:-qm1}
namespace=${4:-mq}
mq_host=$(oc get route -n ${namespace} ${release_name}-ibm-mq-qm -ojson | jq -r .spec.host)

## generate yaml
( echo "cat <<EOF" ; cat ./config/testing-job.yaml.tmpl; echo EOF ) | \
mq_host=${mq_host} \
channel_name=${channel_name} \
queue_name=${queue_name} \
sh > ./config/testing-job.yaml

cat ./config/testing-job.yaml