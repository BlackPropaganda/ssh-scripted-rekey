# ssh scripted rekey
Minimal dependancy linux/unix dash shell scripts that automate SSHD rekeying.

Using a bash shell script, the current keys are moved to a directory called 'keys.back' a ssh command is called, the hash of the script is printed, then the script is executed. The script (null-auth.sh) executed on the server, nullifies the authorized key file in the home directory. It then takes the hash of password authentication configuration file, then restarts the ssh daemon. At which point, the keys are installed using ssh-copy-id. After authentication, a connection test is called to make sure key authentication functions, then the second script (restart-auth.sh) is ran by the same ssh connection as the connection test. This script quickly disables root password authentication for sshd, and restarts the daemon.

In the future I want it to be able to rekey the daemon without enabling remote root logins even for a second. Also, a nice addition would be a tertiary script that simply diables the daemon which could be ran by cron to automatically disable the daemon if rekeying does not occur within 72 hours of the last rekey.
