#!/bin/sh

set -ex

while true; do
    /algorand/node/goal node status
    sleep 5
done &