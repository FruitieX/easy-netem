#!/bin/bash

INTERFACE=$1

tc qdisc change dev $INTERFACE root netem delay ${2}ms
