#!/bin/bash

INTERFACE=$1

tc qdisc change dev $INTERFACE root netem loss ${2}%
