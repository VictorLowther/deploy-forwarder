#!/bin/bash

# Set and reverse ips.
MY_DEV=eth0
MY_IP=$(ip addr show $MY_DEV | grep inet | grep -v inet6 | grep -v $FORWARDER_IP | awk '{ print $2 }')
ip addr add $FORWARDER_IP dev $MY_DEV
ip addr del $MY_IP dev $MY_DEV
ip addr add $MY_IP dev $MY_DEV

dhcp_server=$(cat /etc/hosts | grep dhcp | awk '{ print $1 }' | sort -u)
dhcrelay -4 -i eth0 $dhcp_server

