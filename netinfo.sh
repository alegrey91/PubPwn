#!/bin/sh

separate () {
    #echo "=============="
    echo ""
}

banner() {
    echo "            _   _        __       "
    echo " _ __   ___| |_(_)_ __  / _| ___  "
    echo "| '_ \ / _ \ __| | '_ \| |_ / _ \ "
    echo "| | | |  __/ |_| | | | |  _| (_) |"
    echo "|_| |_|\___|\__|_|_| |_|_|  \___/ "
    echo ""
    echo "by alegrey91"
}

echo ""
banner
separate
net=$(ip route |  grep -oE "([0-9]{1,3}[\.]){3}[0-9]{1,3}/[0-9]{1,3}")
echo "[Gateway]:"
echo $net
separate
echo "[Alive hosts]:"
ips=$(nmap -sn $net | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | cut -d ' ' -f 5)

for ip in $ips;
do
	echo $ip;
done

separate
read -p "Do you want to scan all ip found? [Y/n] " res
res=${res:-Y}
separate

if [ $res = "Y" ]; then
	for ip in $ips;
	do
		echo "[$ip]:"; nmap -T4 -Pn $ip | grep -E "open"
        separate
	done
else
	echo "Scan finished"
fi
