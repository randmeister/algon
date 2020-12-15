#!/bin/sh

set -ex

cp node/genesisfiles/${ALGORAND_NETWORK}/genesis.json $ALGORAND_DATA
/algorand/node/algod -l 0.0.0.0:8080