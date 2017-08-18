#!/bin/bash
HOST="10.45.43.125"
PASSWORD="wangzhongzhoutest123456"
PORT="10079"
if [[ $# == 1 ]];then
    case $1 in
        version)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep redis_version|awk -F[:] '{print $2}'`
            echo $result
        ;;
        connected_clients)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep -w "connected_clients" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory_rss)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep -w "used_memory_rss" | awk -F':' '{print $2}'`
            echo $result
        ;;
        used_memory_peak)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep -w "used_memory_peak" | awk -F':' '{print $2}'`
            echo $result
        ;;

    esac
elif [[ $# == 2 ]];then
    case $2 in
        keys)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep -w "$1" | grep -w "keys" | awk -F'=|,' '{print $2}'`
            echo $result
        ;;
        expires)
            result=`redis-cli -h $HOST -p $PORT -a $PASSWORD info | grep -w "$1" | grep -w "keys" | awk -F'=|,' '{print $4}'`
            echo $result
        ;;
        *)
            echo -e "\033[33mUsage: $0 {db0 keys|db0 expires|db0 avg_ttl}\033[0m"
        ;;
    esac
fi
