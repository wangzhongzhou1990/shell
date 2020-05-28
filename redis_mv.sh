#!/bin/bash
SRC=127.0.0.1
SRC_PORT=6379
SRC_PASSWD=vcredit1
SRC_DB=0
KEY=conversion*
DEST=redis-fn1.vcredit.com.local
DEST_PORT=6379
DEST_PASSWD=V379FengR
DEST_DB=4
redis-cli -h $SRC -p $SRC_PORT -a $SRC_PASSWD -n $SRC_DB --scan --pattern $KEY| while read key
do
redis-cli -h $SRC -p $SRC_PORT -a $SRC_PASSWD -n $SRC_DB --raw dump $key | perl -pe 'chomp if eof' | redis-cli -h $DEST -p $DEST_PORT -a $DEST_PASSWD -n $DEST_DB -x restore $key 0
echo "migrate key $key"
done