easy-netem
==========
Helper scripts for netem

Setup
-----
1. Create the IFB device which can attach qdiscs to incoming packets, redirects packets from INAME. Also add netem to INAME:
  * Run `sudo ./init.sh INAME`

2. Add packet loss (the `LOSS` parameter is an integer from 0 - 100, denotes percentage) with:
  * Outgoing packet loss: `sudo ./pl.sh INAME LOSS`
  * Incoming packet loss: `sudo ./pl.sh ifb0 LOSS`

3. Add latency (the `LAG` parameter is an integer from 0 and up, denotes ms) with:
  * Outgoing latency: `sudo ./lag.sh INAME LAG`
  * Incoming latency: `sudo ./lag.sh ifb0 LAG`

[More info](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
