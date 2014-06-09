#!/bin/bash

INTERFACE=$1

ip link set dev ifb0 down
ip link delete ifb0
tc qdisc del dev $INTERFACE ingress
tc filter del dev $INTERFACE parent ffff: \
	protocol ip u32 match u32 0 0 flowid 1:1 action mirred egress redirect dev ifb0

tc qdisc del dev $INTERFACE root netem
