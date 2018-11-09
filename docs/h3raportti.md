# Palvelinhallintakurssin harjoitus 3

Tässä harjoituksessa tein omia pieniä Salt kokeiluita ja vein tehdyt muutokset git:in.

Tavoitteena oli itselle harjoitella sellaisia Salt tiloja, joita voin hyödyntää kurssin harjoitustyössä. Harjoitustyön aiheena minulla tulee olemaan Flask-ympäristön asentaminen Ubuntulle. Eli voin ajaa Flaskilla tehtyjä Web-ohjelmia selaimessa.

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

```
salasanan muistaminen käytön helpottamiseksi
$ git config --global credential.helper "cache --timeout=3600"
```

Tarkistettu githubista, ja siellä näkyy viimeisin committoitu versio.


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

index.html

Salt Hello!

hosts

127.0.0.1	localhost

127.0.1.1	juha-HP

127.0.0.1	juha.example.com

juha.example.com
```
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
    - fullaname: Juha Immonen project user

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

Käyttäjät luotiin kuitenkin
```
juha@juha-HP:/home$ ls
einari  juha  juhawsgi  matti  mono
```

## Lisätään Apache tilaan mod_wsgi

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


## testiajo uudelle Aapche tilalle
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

Tässä välissä commit, sekä vienti git hubiin.


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

Lisätään top.sls tilaan myös groups.

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
## Teknisen projektikäyttäjän oikeudet ja hakemistojen luonti

Määritellään käyttäjän oikeudet siten, että tämän käyttäjän alle voivat muut käyttäjät tehdä Python-ohjelmia. Määritellään myös, että juhawsgi-käyttäjän kotihakemistossa olevaan alihakemistoon pääsee ryhmän jäsenet

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

Ajetaan tila tässä vaiheessa ja testataan, että hakemisto muodostui ok. 

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

## Testisovellus

Luodaan WSGI-ohjelma
```
$ nano /home/juhawsgi/public_wsgi/juha.wsgi

def application(env, startResponse):
        startResponse("200 OK", [("Content-type", "text/plain")])
        return [b"See you at TeroKarvinen.com\n"]
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

# Tehdään myöhemmin:

Lukitaan käyttäjätunnus, koska se on ryhmätunnus, jolla ei kirjauduta sisään.
```
$ sudo usermod –lock juhawsgi
```
Korjataan käyttäjäryhmä kun luodaan tiedostoja seuraavasti mono -> juhawsgi, hakemistossa

/home/mono/public_wsgi

Tehdään tila,. joka kopioi testiohjelmat (wsgi ja python) ohjelmat oikeaan hakemistoon.

Sen jälkeen Flask-ohjelman tekeminen, projektihakemiston tekeminen ja lopullinen testaus.

Tämän jälkeen puhtaalla Sal tilalla tehtävä sennus on valmis, sitä voidaan lähteä parantamaan Pilareilla ja muoteilla.





