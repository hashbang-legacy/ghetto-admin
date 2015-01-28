#!/bin/bash
#usage ./addadmin existingadmin newadmin

sync_servers="samson gideon abraham melchiz abel noah"

read -s -p "Please enter the sudo/ssh password for $username :" password

for server in $sync_servers; do 
 sudo -S -u $1 ssh $1@$server.hashbang.sh '
 echo '$password' | sudo useradd -d /home/'$2' -G users,sync,wheel '$2'
 sudo mkdir /home/'$2' 
 sudo chown -R '$2':'$2' /home/'$2'
 sudo -u '$2' ssh-keygen -N "'""'" -f /home/'$2'/.ssh/id_rsa
 echo "Please set a sudo password '$2' on '$server'"
 sudo -u '$2' passwd'
done

keyfile=`for each in $sync_servers ; do ssh root@${each}.hashbang.sh cat /home/sync/.ssh/id_rsa.pub; done`
 
