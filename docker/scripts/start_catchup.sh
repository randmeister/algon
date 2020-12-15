#!/bin/sh

set -ex

/algorand/node/goal node catchup `curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/${ALGORAND_NETWORK}/latest.catchpoint`


while true; do
    /algorand/node/goal node status
    sleep 5
done &