#!/bin/bash
# This is a script that can be used for checking all kinds of information about the current state of the network
# I combined a bunch of oneliners I found online into this script that checks a bit of everything

# print IPs currently connected to TCP and UDP ports, filters to fifth column (IP), removes useless port info, sorts, only shows unique lines by counting them together
echo "Unique IPs that are connected to both TCP and UDP:"
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n

# shows list of connections for tcp and udp, prints fifth column, sorts them, cuts useless port info, gets only unique lines, prints number of lines
# useful to see if there are thousands of connections open all of sudden
echo "====="
echo "Total number of connections both to TCP and UDP:"
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n|wc -l

# prints all the open files that mention port 80. Useful for figuring out if Apache is being overloaded
echo "====="
echo "Open file handles that use Apache:"
lsof -i TCP:80 |wc -l

# check for ICMP stats
echo "====="
echo "Number of ICMP packets received/sent recently:"
netstat -s| grep -i icmp | egrep 'received|sent'

# Check the number of SYN requests currently in progress
echo "====="
echo "Number of SYN requests in progress:"
netstat -nap | grep SYN | wc -l

# Check for TCP stats
echo "====="
echo "Unique TCP requests currently in progress:"
netstat -nap | grep 'tcp' | awk '{print $5}' | cut -d: -f1 | sort |uniq -c |sort -n

# Same for UDP
echo "====="
echo "Unique UDP requests currently in progress:"
netstat -nap | grep 'udp' | awk '{print $5}' | cut -d: -f1 | sort |uniq -c |sort -n

