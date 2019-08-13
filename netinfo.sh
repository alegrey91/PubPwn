#!/bin/sh

separate () {
    #echo "=============="
    echo ""
}

banner() {
    echo "               __  .__  _____              "
    echo "  ____   _____/  |_|__|/ ____\____   ____  "
    echo " /    \_/ __ \   __\  \   __\/    \ /  _ \ "
    echo "|   |  \  ___/|  | |  ||  | |   |  (  <_> )"
    echo "|___|  /\___  >__| |__||__| |___|  /\____/ "
    echo "     \/     \/                   \/        "
    echo "by alegrey91"
}

echo ""
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
