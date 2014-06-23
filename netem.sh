#!/bin/bash

INTERFACE=$1
LATENCY=$(($2/2))
PACKETLOSS=$(($3/2))

if [[ -z $3 ]]; then
	echo Usage: netem.sh INAME LATENCY PACKETLOSS
	exit 1
fi

sudo tc qdisc change dev "$INTERFACE" root netem delay "${LATENCY}ms" loss "${PACKETLOSS}%"
sudo tc qdisc change dev "ifb0" root netem delay "${LATENCY}ms" loss "${PACKETLOSS}%"
