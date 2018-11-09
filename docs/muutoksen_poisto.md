# e) Tee tyhmä muutos gittiin, älä tee commit:tia. 

Tehtävä: Tuhoa huonot muutokset ‘git reset –hard’. Huomaa, että tässä toiminnossa ei ole peruutusnappia.

Tehdään muutos README.md tiedoston alkuun. Lisätään sinne asdasdasdasd
```
  $ sudoedit README.md
```
Kokeillaan peruutusta
```
  $ git reset –hard
```
Tulostuu seuraava.
```
$ sudo git reset --hard
HEAD is now at 72c930f mod_wsgi, user directories, virtual name based host, wsgi test program
juha@juha-HP:/srv/salt$ ls
```
README tiedostosta on poistunut alusta asdasdasdasd. Tila on palautunut viimeiseen committiin.


