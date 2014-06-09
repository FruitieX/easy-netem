easy-netem
==========
Helper scripts for netem

Setup
-----
1. Create the IFB device which can attach qdiscs to incoming packets, redirects packets from INAME. Also add netem to INAME:
  * `sudo ./init.sh INAME`

2. Add latency / packet loss (`LOSS` = loss in percentage, from 0 - 100, `LATENCY` = latency in ms):
  * Outgoing: `sudo ./netem.sh INAME LATENCY LOSS`
  * Incoming: `sudo ./netem.sh ifb0 LATENCY LOSS`

3. Delete IFB device and remove netem from INAME:
  * `sudo ./deinit.sh INAME`

[More info](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
