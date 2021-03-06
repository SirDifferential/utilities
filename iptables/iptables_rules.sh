#!/bin/bash

# Accept all established inbound connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow all outgoing
iptables -A OUTPUT -j ACCEPT

# allow everything locally
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Accept HTTP(S)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# log denied accesses (check dmesg)
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7

# Reject all other
iptables -A INPUT -j REJECT
iptables -A FORWARD -j REJECT

