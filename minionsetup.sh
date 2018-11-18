#!/bin/bash
# salt minion installation
# IP is local laptop IP. Should be changed accordingly

apt-get update
apt-get install salt-minion -y 
echo -e 'master: 192.168.10.52\nid: vagminion'|sudo tee /etc/salt/minion
systemctl restart salt-minion
 
