#!/bin/sh

set -ex


cd /algorand/node
./goal wallet new test
./goal account new 
# https://bank.testnet.algorand.network/
./goal account addpartkey -a DC46DLTYOUPK3E2RBQABT6EK7CWA2JYOHHP3Y7FSZM6EKYKLBGF2QRF5RQ --roundFirstValid=11096189 --roundLastValid=14096189
./goal account changeonlinestatus --address=DC46DLTYOUPK3E2RBQABT6EK7CWA2JYOHHP3Y7FSZM6EKYKLBGF2QRF5RQ --fee=2000 --firstvalid= --lastvalid=6003000 --online=true --txfile=online.txn
goal clerk sign --infile="online.txn" --outfile="online.stxn"
goal clerk rawsend --filename="online.stxn"
