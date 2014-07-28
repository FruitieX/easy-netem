easy-netem
==========
Helper scripts for netem

Help
----
`./netem.sh -h`

Setup
-----
1. Initialize on interface INAME:
  * `sudo ./netem.sh INAME init`

2. Add 100ms RTT, 2% packet loss, 1024kbit/s rate limit:
  * `sudo ./netem.sh INAME tc 100 2 1024kbit`

Show netem status
-----------------
`./netem.sh INAME ls`

Deinitialize
------------
`sudo ./netem.sh INAME deinit`

[More info](http://www.linuxfoundation.org/collaborate/workgroups/networking/netem)
