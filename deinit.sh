#!/bin/bash

INTERFACE=$1

rmmod ifb
tc qdisc del dev $INTERFACE ingress
tc qdisc del dev $INTERFACE root netem
