#!/bin/sh

separate () {
    echo ""
}

banner () {
    echo "     _ _                              _     " 
    echo "  __| (_)_ __ ___  ___  __ _ _ __ ___| |__  "
    echo " / _  | |  __/ __|/ _ \/ _  |  __/ __|  _ \ "
    echo "| (_| | | |  \__ \  __/ (_| | | | (__| | | |"
    echo " \__,_|_|_|  |___/\___|\__,_|_|  \___|_| |_|"
    echo ""
    echo "by alegrey91"
}

usage () {
    echo "Usage:"
    echo "  ./dirsearch.sh ip port [path]"
    echo "Example:"
    echo "  ./dirsearch.sh 192.168.1.8 8080 web/"
}

echo ""
banner
separate
if [ $# -lt 2 ]; then
    usage
else
    basedir='seclist/'
    wordlist='common.txt'
    seclist="$basedir$wordlist"
    ip=$1
    port=80
    path=''

    # Checks for 2nd parameter
    if [ $2 != 80 ]; then
        port=$2
    fi
    # Checks for 3th parameter
    if [ ! -z "$3" ]; then
        path=$3
        lastchar=$(echo "${path: -1}")
        if [ "$lastchar" != "/" ]; then
            path=$path"/"
        fi
    fi
    echo "[Results]:"
    # Starting curl requests
    while IFS= read -r line;
    do
        res=$(curl http://$ip:$port/$path$line -I 2>/dev/null |\
            grep -E '^HTTP\/*' |\
            awk '{ print $2 }');
        #echo $res;
        if [ "$res" = "200" ] || [ "$res" = "302" ]; then
            echo "$res  ->  /$line";
        fi
    done < $seclist
    separate
    echo "Search finished"
fi
