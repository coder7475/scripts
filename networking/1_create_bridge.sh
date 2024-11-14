#!/bin/bash

# This script creates a network bridge in a new network namespace
# 
# Parameters:
#   $1 (nsname): Name of the network namespace to create
#   $2 (ifname): Name of the bridge interface
#
# Example usage: 
# create_bridge bridge1 br1
#
# The function:
# 1. Creates a new network namespace
# 2. Enables the loopback interface in the namespace
# 3. Creates a bridge interface in the namespace
# 4. Brings up the bridge interface
# 5. Enables VLAN filtering on the bridge for network segmentation

create_bridge() {
  local nsname="$1"  # Network namespace name
  local ifname="$2"  # Bridge interface name

  echo "Creating bridge ${nsname}/${ifname}"

  # Create new network namespace
  ip netns add ${nsname}
  
  # Enable loopback interface in namespace
  ip netns exec ${nsname} ip link set lo up
  
  # Create and configure bridge interface
  ip netns exec ${nsname} ip link add ${ifname} type bridge
  ip netns exec ${nsname} ip link set ${ifname} up

  # Enable VLAN filtering on bridge for network segmentation
  ip netns exec ${nsname} ip link set ${ifname} type bridge vlan_filtering 1
}
