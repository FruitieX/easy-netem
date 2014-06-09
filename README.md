Create the IFB device which can attach qdiscs to incoming packets, redirects packets from INAME.
Also add netem to INAME:
* Run `sudo ./init.sh INAME`

Add packet loss (the `LOSS` parameter is an integer from 0 - 100, denotes percentage)
* Outgoing packet loss: `sudo ./pl.sh INAME LOSS`
* Incoming packet loss: `sudo ./pl.sh ifb0 LOSS`

[More info](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
