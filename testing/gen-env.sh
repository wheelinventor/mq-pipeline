( echo "cat <<EOF" ; cat ./env.json.tmpl; echo EOF ) | \
sh > env.json
