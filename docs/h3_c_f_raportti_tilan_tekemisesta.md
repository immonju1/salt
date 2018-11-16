# Palvelinhallintakurssin harjoitus 3

Tässä harjoituksessa tein omia pieniä Salt kokeiluita ja vein tehdyt muutokset git:in.

Tavoitteena oli itselle harjoitella sellaisia Salt tiloja, joita voin hyödyntää kurssin harjoitustyössä. Harjoitustyön aiheena minulla tulee olemaan Flask-ympäristön asentaminen Ubuntulle. Eli voin ajaa Flaskilla tehtyjä Web-ohjelmia selaimessa.

Tehtävät on tehty omalla  Hewlett-Packard kotikoneella, jossa Ubuntu 18.04. Muistia 6 GB ja CPU on Intel i5 M 450 @ 2.40GHz.

Master ja minion ovat samalla koneella. Saltin asennus tehty jo aiemmin http://juhaimmonen.com/index.php/2018/11/03/palvelinten-hallinta-harjoitus-2/

## asenna git

    $ sudo apt-get update
    $ sudo apt-get -y install git

### Kopoi repository githubista
```
$ cd /srv
$ sudo git clone https://github.com/immonju1/salt.git
$ cd salt
```

### yhteystiedot
Ensimmäinen commit vaatii antamaan yhteystiedot ensin

```
$ git config --global user.email "jmi@kolumbus.fi"
$ git config --global user.name "Juha Immonen"
```

### git salasanan muistaminen

```
salasanan muistaminen käytön helpottamiseksi
$ git config --global credential.helper "cache --timeout=3600"
```

# git käyttöönotto
## Git testausta Hello Wordilllä


Eli tehdään Salt tila tervetulotoivotus-tiedoston hallintaan, ja samalla testataan, että git toimii.
```
$ mkdir /srv/salt/hello
$ sudoedit init.sls

/tmp/hellojuha.txt:
  file.managed:
    - source: salt://hello/hellojuha.txt
```
```
$ sudoedit hellojuha.txt
Hello Juha!
```
```
$ sudoedit top.sls
base:
  '*':
    - hello
```

## Testataan 
```
$ sudo salt '*' state.highstate
```

Tervehdystiedosto on viety oikeaan paikaan.

juha@juha-HP:/srv/salt$ more 

/tmp/hellojuha.txt 

Hello Juha!


```
slave1:
----------
          ID: /tmp/hellojuha.txt
    Function: file.managed
      Result: True
     Comment: File /tmp/hellojuha.txt is in the correct state
     Started: 10:20:27.205485
    Duration: 31.697 ms
     Changes:   

Summary for slave1
------------
Succeeded: 1
Failed:    0
------------
Total states run:     1
Total run time:  31.697 ms
```

## viedään git:iin (commit)

```
$ sudo git add .
$ sudo git commit
[master 04d77ae] added hello
 3 files changed, 9 insertions(+)
 create mode 100644 hello/hellojuha.txt
 create mode 100644 hello/init.sls
 create mode 100644 top.sls
 ```
 ```
$ sudo git pull
Already up to date.
$ sudo git push
```

Tarkistettu githubista, ja siellä näkyy viimeisin commitoitu versio.


# Varsinaisen harjoitustyön totetuksen aloitus tekemällä tiloja yksi kerrallaan
Tehdään ensin Apache tila

## Apache tila
```
apache2:
  pkg.installed

/etc/hosts:
  file.managed:
    - source: salt://apache/hosts

/var/www/html/index.html:
 file.managed:
   - source: salt://apache/index.html

/etc/apache2/sites-available/juha.example.com.conf:
  file.managed:
    - source: salt://apache/juha.example.com.conf

/etc/apache2/mods-enabled/userdir.conf:
 file.symlink:
   - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
 file.symlink:
   - target: ../mods-available/userdir.load

a2ensite juha.example.com.conf:
  cmd.run

apache2restart:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/juha.example.com.conf
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
```

Muut tiedostot
```
index.html
Salt Hello!
```
```
hosts
127.0.0.1	localhost
127.0.1.1	juha-HP
127.0.0.1	juha.example.com
```
```
juha.example.com

<VirtualHost *:80>

ServerName juha.example.com
ServerAlias www.juha.example.com
DocumentRoot /home/juha/public_html

<Directory /home/juha/public_html>

Require all granted

</Directory>

</VirtualHost>
```

### Apache tilan Testaus

```
$ sudo salt '*' state.highstate
 ```
``` 
slave1:
----------
          ID: /tmp/hellojuha.txt
    Function: file.managed
      Result: True
     Comment: File /tmp/hellojuha.txt updated
     Started: 17:16:40.827266
    Duration: 123.174 ms
     Changes:   
              ----------
              diff:
                  New file
              mode:
                  0644
----------
          ID: apache2
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 17:16:44.730047
    Duration: 1136.793 ms
     Changes:   
----------
          ID: /etc/hosts
    Function: file.managed
      Result: True
     Comment: File /etc/hosts is in the correct state
     Started: 17:16:45.867033
    Duration: 48.025 ms
     Changes:   
----------
          ID: /var/www/html/index.html
    Function: file.managed
      Result: True
     Comment: File /var/www/html/index.html updated
     Started: 17:16:45.915254
    Duration: 33.073 ms
     Changes:   
              ----------
              diff:
                  --- 
                  +++ 
                  @@ -1 +1 @@
                  -Terve Salt
                  +Salt Hello!
----------
          ID: /etc/apache2/sites-available/juha.example.com.conf
    Function: file.managed
      Result: True
     Comment: File /etc/apache2/sites-available/juha.example.com.conf is in the correct state
     Started: 17:16:45.948521
    Duration: 43.202 ms
     Changes:   
----------
          ID: /etc/apache2/mods-enabled/userdir.conf
    Function: file.symlink
      Result: True
     Comment: Symlink /etc/apache2/mods-enabled/userdir.conf is present and owned by root:root
     Started: 17:16:45.991907
    Duration: 2.144 ms
     Changes:   
----------
          ID: /etc/apache2/mods-enabled/userdir.load
    Function: file.symlink
      Result: True
     Comment: Symlink /etc/apache2/mods-enabled/userdir.load is present and owned by root:root
     Started: 17:16:45.994194
    Duration: 1.895 ms
     Changes:   
----------
          ID: a2ensite juha.example.com.conf
    Function: cmd.run
      Result: True
     Comment: Command "a2ensite juha.example.com.conf" run
     Started: 17:16:46.023539
    Duration: 293.657 ms
     Changes:   
              ----------
              pid:
                  3906
              retcode:
                  0
              stderr:
              stdout:
                  Site juha.example.com already enabled
----------
          ID: apache2restart
    Function: service.running
        Name: apache2
      Result: True
     Comment: The service apache2 is already running
     Started: 17:16:46.338655
    Duration: 69.765 ms
     Changes:   

Summary for slave1
------------
Succeeded: 9 (changed=3)
Failed:    0
------------
Total states run:     9
Total run time:   1.752 s
```

Tila ok, viedään git:iin muutokset.
```
$ git add . && git commit; git pull && git push
```
## Tehdään tilat käyttäjien luonnille

```
$ sudo mkdir /srv/salt/users
$ sudoedit init.sls

user_juhawsgi:
  user.present:
    - name: juhawsgi
    - fullname: Juha Immonen project user

user_mono:
  user.present:
    - name: mono
    - fullname: Juha Immonen test user

top.sls
base:
  '*':
    - hello
  'slave*':
    - apache
    - users
```
### testi
```
$ sudo salt '*' state.highstate
```
```
Warnings: 'fullaname' is an invalid keyword argument for 'user.present'. If
              you were trying to pass additional data to be used in a template
              context, please populate 'context' with 'key: value' pairs. Your
              approach will work until Salt Fluorine is out. Please update your
              state files.
```
Tämä varmaan tuli kun tein käyttäjän lisämääreet tilaan suoraan, pitää jatkossa tehdä muottien avulla?

Edit: Tilassa oli kirjoitusvirhe fullaname -> fullname

Käyttäjät luotiin kuitenkin
```
juha@juha-HP:/home$ ls
einari  juha  juhawsgi  matti  mono
```

Tässä välissä commit, sekä push githubiin.

## Lisätään Apache tilaan mod_wsgi

Asennetaan siis apache moduli libapache2-mod-wsgi-py3

Tila muutoksen jälkeen
```
apache2:
  pkg.installed:
    - pkgs:
      - libapache2-mod-wsgi-py3

/etc/hosts:
  file.managed:
    - source: salt://apache/hosts

/var/www/html/index.html:
 file.managed:
   - source: salt://apache/index.html

/etc/apache2/sites-available/juha.example.com.conf:
  file.managed:
    - source: salt://apache/juha.example.com.conf

/etc/apache2/mods-enabled/userdir.conf:
 file.symlink:
   - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
 file.symlink:
   - target: ../mods-available/userdir.load

a2ensite juha.example.com.conf:
  cmd.run

apache2restart:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/juha.example.com.conf
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
```


## testiajo uudelle Apache tilalle
```
$ sudo salt '*' state.highstate
```
```
<...>
          ID: apache2
    Function: pkg.installed
      Result: True
     Comment: 1 targeted package was installed/updated.
     Started: 19:22:41.511638
    Duration: 27765.649 ms
     Changes:   
              ----------
              httpd-wsgi:
                  ----------
                  new:
                      1
                  old:
              libapache2-mod-wsgi-py3:
                  ----------
                  new:
                      4.5.17-1
                  old:

<...>
```
### testaus
```
$ apache2ctl -M|grep -i wsgi
```
Tulostuu:  wsgi_module (shared)

Tässä välissä commit, sekä push githubiin.


## lisätään Python ja Flask
```
$ sudo mkdir /srv/salt/flask
```

Tehdään init.sls
```
flask:
  pkg.installed:
    - pkgs:
      - python3
      - ipython3
      - python3-flask
      - curl
```

Muokataan top.sls
```
base:
  '*':
    - hello
  'slave*':
    - flask
    - apache
    - users
```

### testaus
```
$ sudo salt '*' state.highstate
```
```
snip
          ID: flask
    Function: pkg.installed
      Result: True
     Comment: 2 targeted packages were installed/updated.
              The following packages were already installed: python3, curl
     Started: 19:46:14.118117
    Duration: 37787.791 ms
snip
```

Tehdään commit ja push githubiin

## Lisätään käyttäjäryhmä juhawsgi

Luodaan ryhmä, jota käytetään kehitystyössä.
```
$ mkdir /srv/salt/groups
$ sudoedit init.sls

juhawsgi:
  group.present:
    - addusers:
      - mono
```

Lisätään top.sls tilaan myös tila groups ajettavaksi.

### Testataan

Testataan pelkästään tämä uusi tila
```
$ sudo salt '*' state.apply groups
```
```
----------
          ID: juhawsgi
    Function: group.present
      Result: True
     Comment: The following group attributes are set to be changed:
              addusers: ['mono']
     Started: 11:10:00.963884
    Duration: 490.489 ms
     Changes:   
              ----------
              Final:
                  All changes applied successfully

Summary for slave1
------------
Succeeded: 1 (changed=1)
Failed:    0
-----------t 
Total states run:     1
Total run time: 490.489 ms
```

Katsotaan muodostuiko ryhmä
```
$ cat /etc/group |grep juhawsgi
juhawsgi:x:1002:mono
```

Tila ok, viedään git:iin muutokset.


## Teknisen projektikäyttäjän oikeudet ja hakemistojen luonti

Määritellään käyttäjän kotihakemiston oikeudet.

Määritellään, että juhawsgi-käyttäjän kotihakemistossa olevaan alihakemistoon public_wsgi pääsevät ryhmän jäsenet ja he voivat muokata siellä tiedostoja.

Manuaaliset komennot ovat
```
$ sudo chmod u=rwx,g=x,o=x /home/juhawsgi
$ sudo mkdir /home/juhawsgi/public_wsgi
$ sudo chown juhawsgi.juhawsgi /home/juhawsgi/public_wsgi
$ sudo chmod u=rwx,g=srwx,o=x /home/juhawsgi/public_wsgi
```

Lisätään /srv/salt/users/init.sls
```
/home/juhawsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 711
```

Ajetaan tila tässä vaiheessa ja testataan, että hakemisto muodostui ok. Tarkistettu ja se muodostui ok.

Jatketaan tilan tekemistä.

Lisätään rivi /srv/salt/users/init.sls
```
/home/juhawsgi/public_wsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 771
```

Testaus tilan ajon jälkeen
```
juha@juha-HP:/home/juhawsgi/public_wsgi$ pwd
/home/juhawsgi/public_wsgi
$ sudo ls -la
total 8
drwxrwx--x 2 juhawsgi juhawsgi 4096 marra  8 11:48 .
drwx--x--x 5 juhawsgi juhawsgi 4096 marra  8 11:48 ..
```

Salasana hash käyttäjälle mono
```
openssl passwd -1
```

Lisätään rivi /srv/salt/users/init.sls
```
user_mono:
  user.present:
    - name: mono
    - fullname: Juha Immonen test user
    - password: tähän hash arvo
```

ajetaan tila, ja testataan.
```
$ su mono
```

Toimii eli pääsen kirjatumaan salasanalla mono käyttäjänä sisään.

Tehdään commit ja viedään githubiin.

## Tehdään Hello World WSGI sovellus, jolla voidaan testata koko asennus

Otetaan käyttöön name based virtual host juhawsgi.example.com, josta ajetaan ohjelmat.

Lisätään /srv/salt/apache/hosts tiedostoon rivi

127.0.0.1	juhawsgi.example.com

Tehdään virtual name based konfiguraatiotiedosto
```
$ sudoedit juhawsgi.example.com.conf

<VirtualHost *:80>
    ServerName juhawsgi.example.com

    WSGIScriptAlias / /home/juhawsgi/public_wsgi/juha.wsgi
    <Directory /home/juhawsgi/public_wsgi/>
        Require all granted
    </Directory>

</VirtualHost>
```

Muokataan /srv/salt/apache/init.sls

Lisätään rivit 
```
/etc/apache2/sites-available/juhawsgi.example.com.conf:
  file.managed:
    - source: salt://apache/juhawsgi.example.com.conf
```
ja
```
 - watch:
      - file: /etc/apache2/sites-available/juhawsgi.example.com.conf
```

sekä
```
a2ensite juhawsgi.example.com.conf:
  cmd.run
```

Uusi /srv/salt/apache/init.sls on nyt

```
apache2:
  pkg.installed:
    - pkgs:
      - libapache2-mod-wsgi-py3

/etc/hosts:
  file.managed:
    - source: salt://apache/hosts

/var/www/html/index.html:
 file.managed:
   - source: salt://apache/index.html

/etc/apache2/sites-available/juha.example.com.conf:
  file.managed:
    - source: salt://apache/juha.example.com.conf

/etc/apache2/sites-available/juhawsgi.example.com.conf:
  file.managed:
    - source: salt://apache/juhawsgi.example.com.conf

/etc/apache2/mods-enabled/userdir.conf:
 file.symlink:
   - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
 file.symlink:
   - target: ../mods-available/userdir.load

a2ensite juha.example.com.conf:
  cmd.run

a2ensite juhawsgi.example.com.conf:
  cmd.run

apache2restart:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/juha.example.com.conf
      - file: /etc/apache2/sites-available/juhawsgi.example.com.conf
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
```
## Lisätään top.sls kaikki tilat

```
base:
  '*':
    - hello
  'slave*':
    - flask
    - apache
    - users
    - groups
```

```
$ sudo salt '*' state.highstate
```

Tila ok, viedään git:iin muutokset.

## Testisovellus

Luodaan WSGI-ohjelma
```
$ nano /home/juhawsgi/public_wsgi/juha.wsgi

def application(env, startResponse):
        startResponse("200 OK", [("Content-type", "text/plain")])
        return [b"See you at juhawsgi.example..com\n"]
```


Tiedostoille tuli ryhmä väärin, se pitää korjata Salt tiloihin. Korjataan nyt manuaalisesti, jotta voidaan testata
```
$ sudo chown mono.juhawsgi /home/juhawsgi/public_wsgi/moi.wsgi

$ sudo chown mono.juhawsgi /home/juhawsgi/public_wsgi/moi.py
```

### Testaus

Surffataan juhawsgi.example.com osoitteeseen

Selaimeen tulostuu kuten pitääkin
```
See you at juhawsgi.example.com
```
Tehdään commit ja viedään git:iin

# Tehdään myöhemmin

Lukitaan käyttäjätunnus, koska se on ryhmätunnus, jolla ei kirjauduta sisään.
```
$ sudo usermod –lock juhawsgi
```
Korjataan käyttäjäryhmä kun luodaan tiedostoja hakemistossa /home/juhawsgi/public_wsgi

Tehdään tila, joka kopioi testiohjelmat (wsgi ja python) oikeaan hakemistoon.

Tehdään tila, joka asentaa PostgreSQL:n ja luo kantatunnuksen.

Sen jälkeen Flask-ohjelman tekeminen, projektihakemiston tekeminen ja lopullinen testaus.

Tämän jälkeen puhtaalla Salt tilalla tehtävä asennus on valmis, sitä voidaan lähteä parantamaan Pilareilla ja muoteilla.

# Vagrant asennus

Jatkettu 15.11.2017

Asennetaan välissä vagrant, jotta voidaan testata paremmin asentamista puhtaalle koneelle.

    $ sudo apt-get install -y vagrant virtualbox
    $ mkdir vag
    $ vagrant init bento/ubuntu-16.04
    $ vagrant up

Virheilmoitus
```
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["startvm", "adf42730-315c-4941-8fc2-4f26e44f2b49", "--type", "headless"]

Stderr: VBoxManage: error: VT-x is disabled in the BIOS for all CPU modes (VERR_VMX_MSR_ALL_VMX_DISABLED)
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole
```
Korjattu VT-x asetus, jonka jälkeen 

    $ vagrant up
    $ vagrant up
    $ vagrant ssh

Siirrytään vagrantille

    vagrant$ sudo apt-get update
    vagrant$ sudo apt-get install -y salt-minion

    vagrant$ echo -e "master: 192.168.10.52\nid: slave2" | sudo tee /etc/salt/minion

    vagrant$ sudo systemctl restart salt-minion

    master$ sudo salt-key -A

Minionin avain on ollut aiemmin toisella koneella.

Pitää poistaa aiemmalla vagrant minionilla ollut avain.
```
master$ sudo salt-key -L
master$ sudo salt-key -d slave2
The following keys are going to be deleted:
Accepted Keys:
slave2
Denied Keys:
slave2
Proceed? [N/y] y
Key for minion slave2 deleted.
Key for minion slave2 deleted.
```

```
vagrant$ sudo systemctl restart salt-minion

master$ sudo salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
slave2
Proceed? [n/Y] y
Key for minion slave2 accepted.
```
# Ensimmäinen testi puhtaalle koneelle

Testi on tehty HH labran koneella, Ubuntu 18.04 livetikulta. 

Asensin Salt Masterin ja Minionin samalle koneelle.

Hain tilan git:stä komennolla
   
    $ cd /srvs
    $ sudo git clone https://github.com/immonju1/salt.git
    $ cd salt

Ajettu tila

    $ sudo salt '*' state.highstate

Lopputulos oli se, että tilan ei asentunut oikein, koska Apache2 asennus puuttui tilasta.

Olen testannut tilaa vain omalla koneella, jossa oli jo valmiina Apache2. Tämän takia virhe ei tullut esille aiemmin.

lisätty apache tilaan Apache2 asennus

```
apache2:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-wsgi-py3
```
Tämän jälkeen tila asentui ok tyhjälle koneelle.

# Jatketaan oman miniprojektin tekemistä

Tässä vaiheessa on menossa mod_wsgi ohjelman ajaminen. ts. tavoitteena on saada tila siihen pisteeseen, että voidaan ajaa selaimessa Python wsgi-ohjelma.

Käyttäjille pitää määritellä komentotulkiksi /bin/bash

Lisätty users/init.sls seuraavat rivit 

```
shell: /bin/bash
```

Luotudaan index.html tiedosto mono käyttäjän public_html hakemistoon

```
/home/mono/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
```

Muutetan top.sls, koska haluan muutokset puhtaalle Vagrant minionille
```
base:
  '*':
    - hello
  'slave2':
    - flask
    - apache
    - users
    - groups
```

## Testaus
    
    sudo salt '*' state.highstate

```
vagrant@vagrant:~$ curl juha.example.com
Tama on Mono kotihakemisto
```

### Korjattavaa vielä löytyy.

Oikeudet pitää saada kuntoon /home/mono/public_html, index.html jäi rootille

```
-rw-r--r-- 1 root root   27 Nov 15 09:33 index.html
```

Muutetaan users/init.sls
```
/home/mono/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
    - user: mono
    - group: mono
    - mode: 711
```

Uusille tiedostoille ei tule oikeaa ryhmää tällä hetkellä hakemistoon /home/juhawsgi/public_wsgi

Tämän voi korjata komennolla chmod g+s /home/juhawsgi/public_wsgi

Muutetaan
```
/home/mono/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
    - user: mono
    - group: mono
    - mode: 711
```

## Testaus uudestaan

    $ sudo salt '*' state.highstate

Toimii
```
mono@vagrant:~/public_html$ ls -la
total 12
drwx--x--x 2 mono mono 4096 Nov 15 09:48 .
drwxr-xr-x 4 mono mono 4096 Nov 15 09:42 ..
-rwx--x--x 1 mono mono   27 Nov 15 09:33 index.html
```

Muutetaan /users/init.sls muotoon, jotta saadaan s-flag päälle.

```
/home/juhawsgi/public_wsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 4771
```

## Lopetetaan työskentely 
```
$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```

# Viimeistellään mod_wsgi vaihe


Testaus, joka kesken:
 
Edellisessä vaiheessa komento mode 4711 users-tilassa, sen testaaminen. Jotta luotavien tiedostojen ryhmä tulee oikein.

Käynnistetään uusi vagrant ja jatketaan testausta.

```
$ vagrant up
$ vagrant ssh
$ sudo apt-get update
$ sudo apt-get install -y salt-minion
```

Tehdään samat askelteet kuin alussa. Varattu slave2 avain pitää poistaa masterilta.

Lisätään users-tilaan Python WSGI-koodin siirtäminen oikeaan hakemistoon.

Lisätään /users/init.sls

```
/home/juhawsgi/public_wsgi/juha.wsgi:
  file.managed:
    - source: salt://users/juha.wsgi
    - user: juhawsgi
    - group: juhawsgi
    - mode: 771
```

Ajettava koodi juha.wsgi

```
juha.wsgi
def application(env, startResponse):
        startResponse("200 OK", [("Content-type", "text/plain")])
        return [b"Hello World from Python 3 WSGI\n"]
```

## Testaus

    sudo salt '*' state.highstate

Testataan

Testit

- Muodostuuko ryhmät ok tiedostoille hakemistossa 
/home/juhawsgi/public_wsgi

- Voiko ohjelma ajaa selaimessa
juhawsgi.example.com

```
vagrant@vagrant:~$ curl juhawsgi.example.com
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>500 Internal Server Error</title>
</head><body>
<h1>Internal Server Error</h1>
<p>The server encountered an internal error or
misconfiguration and was unable to complete
your request.</p>
<p>Please contact the server administrator at 
 [no address given] to inform them of the time this error occurred,
 and the actions you performed just before this error.</p>
<p>More information about this error may be available
in the server error log.</p>
<hr>
<address>Apache/2.4.18 (Ubuntu) Server at juhawsgi.example.com Port 80</address>
</body></html>
```

Apache error lokissa:

```
[Thu Nov 15 11:43:24.025169 2018] [wsgi:error] [pid 31622:tid 140183026525952] (13)Permission 
denied: [client 127.0.0.1:56304] mod_wsgi (pid=31622, process='', application='juhawsgi.exampl
e.com|'): Call to fopen() failed for '/home/juhawsgi/public_wsgi/juha.wsgi'.
```

Myöskään juha.example.com ei toimi, eli ei toimi myöskään web-sivut käyttäjien kotihakemistosta.
```
vagrant@vagrant:~$ curl juha.example.com
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>403 Forbidden</title>
</head><body>
<h1>Forbidden</h1>
<p>You don't have permission to access /index.html
on this server.<br />
</p>
<hr>
<address>Apache/2.4.18 (Ubuntu) Server at juha.example.com Port 80</address>
</body></html>
```

## Selvitetty hakemistojen ja tiedostojen oikeuksia ja muutettu ne oikeiksi

Korjattu users/init.sls tila on nyt

```
juha@juha-HP:/srv/salt/users$ cat init.sls 
user_juhawsgi:
  user.present:
    - name: juhawsgi
    - shell: /bin/bash
    - fullname: Juha Immonen project user

user_mono:
  user.present:
    - name: mono
    - shell: /bin/bash
    - fullname: Juha Immonen test user
    - password: hash

/home/mono/public_html:
  file.directory:
    - user: mono
    - group: mono
    - mode: 755 # muutettu

/home/mono/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
    - user: mono
    - group: mono
    - mode: 755 # muutettu

/home/juhawsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 711

/home/juhawsgi/public_wsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 771

/home/juhawsgi/public_wsgi/juha.wsgi:
  file.managed:
    - source: salt://users/juha.wsgi
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764 # muutettu

# chmod g+s
run_s_right:
  cmd.run:
    - name: chmod u=rwx,g=srwx,o=x /home/juhawsgi/public_wsgi
```

## Testaaan uudestaan vagrant monionilla

    $ sudo salt '*' state.highstate

### Kotihakemistoista web-sivu toimii

```
vagrant@vagrant:~$ curl juha.example.com
Tama on Mono kotihakemisto
```

### wsgi-ohjelma toimii
```
vagrant@vagrant:~$ 
vagrant@vagrant:~$ curl juhawsgi.example.com
Hello World from Python 3 WSGI
```

### tiedostollle oikea ryhmä hakemistossa /public_wsgi
```
nano kor.txt
-rw-rw-r-- 1 mono     juhawsgi    6 Nov 15 13:11 kor.txt
```

Oikea ryhmä ja oikeudet tulivat tiedostolle, joka luotiin hakemistoon.

Tässä vaiheessa commit ja push githubiin.

# Seuraavat vaiheet

Jatketaan näillä

Tietokanta käyttöön

- PostgreSQL
- Kantatunnus

Flask ohjelma

- Flask ohjelma, templatet
- Projektille hakemistorakenne
- Virtual Name Based host uudelleen konfigurointi Flask ohjelmaa varten
- Flask ohjelman vienti oikeisiin hakemistoihin

# Mahdollisia parannuksia myöhemmin

Python koodi haetaan aina versionhallinnasta.




