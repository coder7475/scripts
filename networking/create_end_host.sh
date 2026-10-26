# This script creates an end host in a new network namespace and connects it to a bridge
# 
# Parameters:
#   $1 (host_nsname): Name of the network namespace for the end host
#   $2 (peer1_ifname): Name of the veth interface in the host namespace
#   $3 (vlan_vid): VLAN ID to assign to the host
#   $4 (bridge_nsname): Name of the bridge's network namespace
#   $5 (bridge_ifname): Name of the bridge interface
#
# Example usage:
# create_end_host host1 veth1 100 bridge1 br1
#
# This will:
# 1. Create a new namespace "host1" for the end host
# 2. Create veth pair "veth1" and "veth1b" connecting host1 to bridge1
# 3. Connect "veth1b" to bridge "br1" in bridge1 namespace
# 4. Configure VLAN 100 for the host's connection

create_end_host() {
  local host_nsname="$1"
  local peer1_ifname="$2"
  local peer2_ifname="$2b"
  local vlan_vid="$3"
  local bridge_nsname="$4"
  local bridge_ifname="$5"

  echo "Creating end host ${host_nsname} connected to ${bridge_nsname}/${bridge_ifname} bridge (VLAN ${vlan_vid})"

  # Create end host network namespace.
  ip netns add ${host_nsname}
  ip netns exec ${host_nsname} ip link set lo up

  # Create a veth pair connecting end host and bridge namespaces.
  ip link add ${peer1_ifname} netns ${host_nsname} type veth peer \
              ${peer2_ifname} netns ${bridge_nsname}
  ip netns exec ${host_nsname} ip link set ${peer1_ifname} up
  ip netns exec ${bridge_nsname} ip link set ${peer2_ifname} up

  # Attach peer2 interface to the bridge.
  ip netns exec ${bridge_nsname} ip link set ${peer2_ifname} master ${bridge_ifname}

  # Put host into right VLAN
  ip netns exec ${bridge_nsname} bridge vlan del dev ${peer2_ifname} vid 1
  ip netns exec ${bridge_nsname} bridge vlan add dev ${peer2_ifname} vid ${vlan_vid} pvid ${vlan_vid}
}
