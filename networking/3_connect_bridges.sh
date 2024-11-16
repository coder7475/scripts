# This function connects two Linux bridges in different network namespaces using a veth pair
# 
# Parameters:
#   $1 (bridge1_nsname): Name of the first bridge's network namespace
#   $2 (bridge1_ifname): Name of the first bridge interface
#   $3 (bridge2_nsname): Name of the second bridge's network namespace 
#   $4 (bridge2_ifname): Name of the second bridge interface
#
# Example usage:
# connect_bridges bridge1 br1 bridge2 br2
#
# This will:
# 1. Create a veth pair with interfaces named veth_br2 and veth_br1
# 2. Place veth_br2 in bridge1's namespace and connect it to br1
# 3. Place veth_br1 in bridge2's namespace and connect it to br2
# 4. Enable both veth interfaces
connect_bridges() {
  local bridge1_nsname="$1"
  local bridge1_ifname="$2"
  local bridge2_nsname="$3"
  local bridge2_ifname="$4"
  local peer1_ifname="veth_${bridge2_ifname}"
  local peer2_ifname="veth_${bridge1_ifname}"

  echo "Connecting bridge ${bridge1_nsname}/${bridge1_ifname} to ${bridge2_nsname}/${bridge2_ifname} bridge using veth pair"

  # Create veth pair.
  ip link add ${peer1_ifname} netns ${bridge1_nsname} type veth peer \
              ${peer2_ifname} netns ${bridge2_nsname}
  ip netns exec ${bridge1_nsname} ip link set ${peer1_ifname} up
  ip netns exec ${bridge2_nsname} ip link set ${peer2_ifname} up

  # Connect bridges.
  ip netns exec ${bridge1_nsname} ip link set ${peer1_ifname} master ${bridge1_ifname}
  ip netns exec ${bridge2_nsname} ip link set ${peer2_ifname} master ${bridge2_ifname}
}
