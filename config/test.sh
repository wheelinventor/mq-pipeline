## generate yaml
( echo "cat <<EOF" ; cat ./testing-job.yaml.tmpl; echo EOF ) | \
sh > ./testing-job.yaml

cat ./testing-job.yaml