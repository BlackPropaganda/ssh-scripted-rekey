#!/bin/sh

# simple script used to copy config files and restart the daemon
# in a way that minimizes the threat of forgetting to disable the
# daemons password auth needed to key the root user using
# ssh-copy-id.
#
# This file needs to be in the same directory in order to be called
# remotely using a different script.

truncate -s 0 $HOME/.ssh/authorized_keys
pass_auth_expected_hash="SHA512 (pass_auth.txt) = 754c54811df0231adcea0643c0eb077a19c8393fc22a9755a04a193d52bfc2cebfc38ada812115a6055c9c3273f55e9c63d58aea3b759e08848b19e2941bfac6"
echo "SHA512 Sum: "$(cd && sha512 pass_auth.txt)
echo "Expected:   "$pass_auth_expected_hash
cp /root/scripts/pass_auth.txt /etc/ssh/sshd_config
