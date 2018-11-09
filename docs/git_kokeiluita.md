
# Harjoitus 3, tehtävä d) Näytä omalla salt-varastollasi esimerkit komennoista ‘git log’, ‘git diff’ ja ‘git blame’. Selitä tulokset

## git log

Näyttää commit lokit.


    $ sudo git log

 
commit 72c930f1e676771b856c55d792b058900adaa93c (HEAD -> master, origin/master, origin/HEAD)
Author: Juha Immonen <jmi@kolumbus.fi>
Date:   Thu Nov 8 14:14:58 2018 +0200

    mod_wsgi, user directories, virtual name based host, wsgi test program

commit eb368028f6a93bc6973a03d98ddf301059aca2c9
Author: Juha Immonen <jmi@kolumbus.fi>
Date:   Wed Nov 7 19:49:52 2018 +0200

    Python and Flask

commit e90f91c0e0044e55401723d9731a529565a42d64
Author: Juha Immonen <jmi@kolumbus.fi>
Date:   Wed Nov 7 19:29:21 2018 +0200

    users and mod_wsgi added

commit 1692d401fa139260fc9e1a2cccdcf2215133cd03
Author: Juha Immonen <jmi@kolumbus.fi>
Date:   Wed Nov 7 17:33:44 2018 +0200

    Apache state

commit 04d77ae96d26fa55d0313aff6c69c7ce57bb4787
Author: Juha Immonen <jmi@kolumbus.fi>
Date:   Wed Nov 7 10:30:58 2018 +0200

    added hello

commit 3ddecc1440932d4ece55596418be0af92a5411e9
Author: immonju1 <42608886+immonju1@users.noreply.github.com>
Date:   Tue Nov 6 15:03:23 2018 +0000

    Create README.md

commit ee6168d299e6bd85772d95be78fd8c2ee5826edd
Author: immonju1 <42608886+immonju1@users.noreply.github.com>
Date:   Tue Nov 6 15:02:42 2018 +0000

    Initial commit
 

commit lokissa näkyy kommenttiyh, commit id,kuka teki commitin ja aikaleima

## git diff’

    $ sudo git diff ee6168d299e6bd85772d95be78fd8c2ee5826edd 3ddecc1440932d4ece55596418be0af92a5411e9
```
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..08c9265
--- /dev/null
+++ b/README.md
@@ -0,0 +1,2 @@
+# salt
+Salt modules
```
Lisätty tyhjään REAMDE tiedostoon tekstiä

salt

Salt modules

## git blame

    $ sudo git blame README.md 

Lyhyt katkelma, näkyy kuka tehnyt muutokset ja aikaleima
```
2c930f1 (Juha Immonen 2018-11-08 14:14:58 +0200  2) Tämä on harjoittelua palvelintenhallinta-kurssille.
72c930f1 (Juha Immonen 2018-11-08 14:14:58 +0200  3) 
72c930f1 (Juha Immonen 2018-11-08 14:14:58 +0200  4) Tavoitteena saada lopulta flask-ympäristö asennettua palvelimelle. Edetään palanen kerrallaan.
72c930f1 (Juha Immonen 2018-11-08 14:14:58 +0200  5) 
```