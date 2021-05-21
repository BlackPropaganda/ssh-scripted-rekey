#!/bin/bash

host_ip_address="192.168.1.1"
host_port="22"
priv_key_file="key"
pub_key_file="key.pub"
algorithm="rsa"
keysize="4096"
account="root"

server_null_auth_expected_hash=""
server_restart_auth_expected_hash=""

# copies current keys to backup directory
mv $priv_key_file /keys.back/$priv_key_file
mv $pub_key_file /keys.back/$pub_key_file

# generates new keys
echo "<<< GENERATING KEYS >>>"
ssh-keygen -t $algorithm -b $keysize -f $(pwd)/$priv_key_file

# remote script execution
echo " <<< SSH REMOTE SCRIPT EXECUTING >>>"
sleep 2
# PLACE SERVER SCRIPT IN HOME DIRECTORY 'scripts'
# SSH's into host using old key for the last time.
echo "expected:                        "$server_null_auth_expected_hash
ssh -i keys.back/$priv_key_file -p $host_port $account@$host_ip_address 'cd; sha512sum scripts/null-auth.sh'
ssh -i keys.back/$prib_key_file -p $host_port $account@$host_ip_address 'cd; sh scripts/null-auth.sh'


# rekeying
sleep 1
echo "<< COPYING KEYS >>"
ssh-copy-id -i $priv_key_file -p $host_port $account@$host_ip_address

echo "[!] CONNECTION TEST & CLEANUP [!]"
# PLACE REMOTE SCRIPT IN HOME DIRECTORY 'scripts'
echo "expected:                        "$server_null_auth_expected_hash
ssh -i $priv_key_file -p $port $host_ip_address 'cd; sha512sum scripts/restart-auth.sh'
ssh -i $priv_key_file -p $port $host_ip_address 'cd && sh scripts/restart-auth.sh && exit'
echo "< CONNECTION TEST COMPLETE>"
