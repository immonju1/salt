# Tee skripti, joka tekee koneestasi salt-orjan

minionsetup.sh

```
#!/bin/bash
# salt minion installation
# IP is local laptop IP. Should be changed accordingly

apt-get update
apt-get install salt-minion -y 
echo -e 'master: 10.0.2.2\nid: vagminion'|sudo tee /etc/salt/minion
systemctl restart salt-minion
```

# haku githubista

```
$ wget https://raw.githubusercontent.com/immonju1/salt/master/minionsetup.sh

--2018-11-18 11:26:37--  https://raw.githubusercontent.com/immonju1/salt/master$
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.84.1$
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.84.$
HTTP request sent, awaiting response... 200 OK
```

# Testaus 
# Vagrantilla minion
```
$ vagrant up
$ vagrant ssh
```

```
wget https://raw.githubusercontent.com/immonju1/salt/master/minionsetup.sh
chmod g+x minionsetup.sh
sudo ./minionsetup.sh
```


## Master konfigurointi

Avaimen hyväksyntä.

```
juha@juha-HP:~$ sudo salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
vagminion
Proceed? [n/Y] y
Key for minion vagminion accepted.
```

Testi

```
juha@juha-HP:~$ sudo salt '*' cmd.run 'whoami'
slave1:
    root
vagminion:
    root
```


