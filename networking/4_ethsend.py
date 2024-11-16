#!/usr/bin/env python3
# This script sends raw Ethernet frames from a network interface to a destination MAC address
#
# Usage: ethsend eth0 ff:ff:ff:ff:ff:ff 'Hello everybody!'
#        ethsend eth0 06:e5:f0:20:af:7a 'Hello 06:e5:f0:20:af:7a!'
#
# Parameters:
#   interface: Network interface to send from (e.g. eth0)
#   dst_mac: Destination MAC address in XX:XX:XX:XX:XX:XX format
#   payload: Message to send in the Ethernet frame
#
# The script will:
# 1. Open a raw socket bound to the specified interface
# 2. Get the source MAC address of the interface
# 3. Construct an Ethernet frame with:
#    - Destination MAC from command line
#    - Source MAC from interface
#    - EtherType 0x7A05 (arbitrary, non-reserved value)
#    - Payload from command line
# 4. Send the frame on the wire
#
# Note: CAP_NET_RAW capability is required to use SOCK_RAW

import fcntl
import socket
import struct
import sys

def send_frame(ifname, dstmac, eth_type, payload):
  # Open raw socket and bind it to network interface.
  # AF_PACKET allows sending at Layer 2 (Ethernet)
  # SOCK_RAW provides raw network protocol access
  s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
  s.bind((ifname, 0))

  # Get source interface's MAC address using ioctl syscall
  # 0x8927 is SIOCGIFHWADDR - get hardware address of interface
  info = fcntl.ioctl(s.fileno(),
                     0x8927,
                     struct.pack('256s', bytes(ifname, 'utf-8')[:15]))
  srcmac = ':'.join('%02x' % b for b in info[18:24])

  # Build Ethernet frame
  # Convert payload to bytes and verify it's within MTU limit
  payload_bytes = payload.encode('utf-8')
  assert len(payload_bytes) <= 1500  # Ethernet MTU

  # Construct frame: dst MAC + src MAC + EtherType + payload
  frame = human_mac_to_bytes(dstmac) + \
          human_mac_to_bytes(srcmac) + \
          eth_type + \
          payload_bytes

  # Send Ethernet frame and return number of bytes sent
  return s.send(frame)

def human_mac_to_bytes(addr):
  # Convert MAC address from XX:XX:XX:XX:XX:XX format to bytes
  return bytes.fromhex(addr.replace(':', ''))

def main():
  # Get command line arguments
  ifname = sys.argv[1]    # Interface name
  dstmac = sys.argv[2]    # Destination MAC
  payload = sys.argv[3]   # Frame payload
  ethtype = b'\x7A\x05'   # Custom EtherType (arbitrary, non-reserved)
  send_frame(ifname, dstmac, ethtype, payload)

if __name__ == "__main__":
  main()

# ⚠️ CAP_NET_RAW capability is required to run the above code (or just use sudo).