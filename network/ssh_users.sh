#!/bin/bash

sudo grep -i 'session opened' /var/log/auth.log |grep sshd
