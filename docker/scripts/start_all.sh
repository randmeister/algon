#!/bin/sh

set -e

# Start algod
cp node/genesisfiles/${ALGORAND_NETWORK}/genesis.json ${ALGORAND_DATA}
/algorand/node/algod -l 0.0.0.0:8080 &

# Fast catchup
/algorand/node/goal node catchup `curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/${ALGORAND_NETWORK}/latest.catchpoint`

# Write node status to stdout
while true; do
    /algorand/node/goal node status
    sleep 10
done &

# Write node.log to stdout
tail -f ${ALGORAND_DATA}/node.log