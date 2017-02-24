#!/usr/bin/env bash

LATENCY="500ms"
VARIATION="100ms"

enableNetEm(){
	$(sudo tc qdisc replace dev wlp3s0 root netem delay $(echo $LATENCY) $(echo $VARIATION) distribution normal)
}
disableNetEm(){
	sudo tc qdisc replace dev wlp3s0 root pfifo
}

case $1 in 
    enable)
	LATENCY=$2
	VARIATION=$3
	enableNetEm
	echo "Latency emulation enabled"
    ;;
    disable)
	disableNetEm
	echo "Latency emulation disabled"
    ;;
    *)
	echo "Usage: netEm.sh [enable|disable] latency variation"
    ;;
esac
