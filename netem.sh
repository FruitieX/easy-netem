#!/bin/bash
INTERFACE="$1"
CMD="$2"

 # exit on errors
set -e

printhelp() {
    echo "Usage: netem.sh INAME CMD"
    echo "Valid CMDs are:"
    echo
    echo "tc LATENCY LOSS [RATE]"
    echo "  set traffic control paramerers:"
    echo
    echo "  LATENCY is in ms"
    echo "  LOSS is in percent"
    echo "  RATE is optional and can be given as e.g. \"128kbit\", see tc man pages for more units."
    echo "    A value of 0 turns rate limits off."
    echo
    echo "init"
    echo "  initializes the given INAME for netem"
    echo
    echo "deinit"
    echo "  deinitializes netem on the given INAME"
    echo
    echo "ls"
    echo "  lists qdiscs on the given INAME"
}

# second argument is "ls", print qdiscs on given INAME
if [[ "$CMD" == "ls" ]]; then
    tc -s qdisc ls dev "$INTERFACE"

# second argument is "init", init netem on given INAME
elif [[ "$CMD" == "init" ]]; then
    # check root privilegies
    if [[ "$(whoami)" != "root" ]]; then
        echo "This action needs root privilegies. Please re-run as root."
        exit 1
    fi

    # outgoing traffic netem
    tc qdisc add dev $INTERFACE root netem

    # incoming traffic netem
    modprobe ifb
    ip link set dev ifb0 up
    tc qdisc add dev $INTERFACE ingress
    tc filter add dev $INTERFACE parent ffff: \
        protocol ip u32 match u32 0 0 flowid 1:1 action mirred egress redirect dev ifb0

    tc qdisc add dev ifb0 root netem

# second argument is "init", init netem on given INAME
elif [[ "$CMD" == "deinit" ]]; then
    # check root privilegies
    if [[ "$(whoami)" != "root" ]]; then
        echo "This action needs root privilegies. Please re-run as root."
        exit 1
    fi

    rmmod ifb
    tc qdisc del dev $INTERFACE ingress
    tc qdisc del dev $INTERFACE root netem

elif [[ "$CMD" == "tc" ]]; then
    # delay/loss arguments are mandatory in tc command
    if [[ -z "$4" ]]; then
        echo "ERROR: Not enough arguments for tc command."
        echo
        printhelp
        exit 1
    fi

    LATENCY="delay $(($3/2))ms"
    LOSS="loss $(($4/2))%"

    # fourth argument given
    if [[ ! -z "$5" ]]; then
        RATE="rate $5"
    fi

    # check root privilegies
    if [[ "$(whoami)" != "root" ]]; then
        echo "This action needs root privilegies. Please re-run as root."
        exit 1
    fi

    tc qdisc change dev "$INTERFACE" root netem $LATENCY $LOSS $RATE
    tc qdisc change dev "ifb0" root netem $LATENCY $LOSS $RATE

# at least three args must be given
else
    printhelp
    exit 1
fi

