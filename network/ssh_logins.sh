#!/bin/bash
# Prints information about failed root logins and sorts them by IP

grep 'more authentication failures' /var/log/auth.log |grep 'user=root' | awk '{print $16}' | uniq -c | sed 's/rhost=//g'
grep 'more authentication failures' /var/log/auth.log |grep 'user=root' | awk '{print $16}' | uniq -c | sed 's/rhost=//g' | awk {'print $2}' > ssh_fails.log
echo "Total of number of IPs that attempted to login as root over 5 times:"
cat ssh_fails.log |wc -l
echo "Wrote only IP output to ssh_fails.log"

