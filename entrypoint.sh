#!/usr/bin/env bash

set -ex

# start SSH tunnel in the background
ssh -i ./ssh_key "tunnel@${GCE_IP?:GCE_IP environment variable not set}" \
    -N -D localhost:5000 \
    -o StrictHostKeyChecking=no &

# start web server in the background
# TODO: use gunicorn here as 'flask' command is not
# production ready, and should be used only for dev purposes
env HTTPS_PROXY="socks5://localhost:5000" \
    gunicorn --bind ":${PORT:-8080}" --workers 1 --threads 8 app:app &

# wait -n helps us exit immediately if one of the processes above exit.
# this way, Cloud Run can restart the container to be healed.
wait -n
