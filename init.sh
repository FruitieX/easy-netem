#!/bin/bash

INTERFACE=$1

# outgoing traffic netem
tc qdisc add dev $INTERFACE root netem

# incoming traffic netem
modprobe ifb
ip link set dev ifb0 up
tc qdisc add dev $INTERFACE ingress
tc filter add dev $INTERFACE parent ffff: \
	protocol ip u32 match u32 0 0 flowid 1:1 action mirred egress redirect dev ifb0
