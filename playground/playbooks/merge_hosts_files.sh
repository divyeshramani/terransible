#!/bin/bash
rm -f hosts
tail -n +1 hosts_* | sed  -e 's/==> /[/g' | sed -e 's/ <==/]/g' | sed -e 's/\[hosts_/\[/g' > hosts
rm -f hosts_*
