#!/bin/sh

set -ex

cp node/genesisfiles/${ALGORAND_NETWORK}/genesis.json ${ALGORAND_DATA}
/algorand/node/algod -l 0.0.0.0:8080 &
/algorand/node/node_exporter &
/algorand/node/goal node catchup `curl https://algorand-catchpoints.s3.us-east-2.amazonaws.com/channel/${ALGORAND_NETWORK}/latest.catchpoint`
while true; do
    /algorand/node/goal node status
    sleep 5
done &
tail -f ${ALGORAND_DATA}/node.log