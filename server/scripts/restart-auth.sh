#!/bin/sh

#
# reinstalls key auth and restarts the daemon
#


trusted_config_hash="SHA512 (key_auth.txt) = 2e14d622b6127e922cde8aa8453266a67bb52f2d457d1ed7a2e003521c285eb0fe3a9f2dd1e051a501331eda383b54dcfd54ae4fc18750e21f26ab07ee5781f5"
current_hash=$(sha512 /root/scripts/key_auth.txt)

echo "<trusted hash>               "$trusted_config_hash
echo "<current hash> "$current_hash

cp /root/scripts/key_auth.txt /etc/ssh/sshd_config
service sshd restart
