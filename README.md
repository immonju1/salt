# Python Flask ympäristön asennus palvelimille Saltilla

Tämä on miniprojekti palvelintenhallintakurssille.

Tavoitteena saada lopulta flask-ympäristö asennettua palvelimelle.

Tehtävän dokumentaatio https://github.com/immonju1/salt/tree/master/docs

## Käyttäjätarina

Koodaajana haluan, että minulla on tuotantoa vastaava Python Flask ympäristö, jotta voin testata sovellustani oikeassa ympäristössä.

Tätä Salt tilaa voi käyttää kehittäessään Python Flask ohjelmaa. Sovelluksen kehitys tapahtuu kehitysympäristössä. Githubiin viennin jälkeen voi ajaa tämän tilan, jolloin ohjelma asentuu testiympäristöön.

Tila automatisoi ohjelman deploymentin testiympäristöön, tila pitää kuitenkin ajaa itse manuaalisesti sovellukselle tehdyn git push jälkeen.

### Parannettavaa

Riippuvuuksien hallinta, kehitysympäristössä on venv, ja tietyt versiot esim. Python Flask moduuleista. Miten saada samat komponentit samoilla versoinumeroilla Saltin kautta testiympäristöön.

Eri ympäristöjen konfigurointi, esim. kehitysympäristössä on käytössä Sqlite3, mutta testissä PostgreSQL. Ohjelman pitää lukea jostain missä ympärsitössä ollaan.

Deploymentin automatisointi, kun on tehty git push githubiin, tapahtuisi automaattisesti deployment tämän tilan avulla.

## Hyväksyntäkriteerit:

Salt asentaa seuraavat asiat

### Ympäristö

Salt tila toimii Ubuntu 18.04 alustalla. Ubuntu 16.04 ei toimi, johtuen siitä että tarvtaan Python3. 

Kaikkia tarvittavia Python Flask kirjastoja ei ole saatavilla Ubuntu 16.04 (flask-login).

### Käyttäjät ja hakemistot

- Käyttäjätunnus kehittäjälle
- Tekninen käyttäjä projektille, jolla ei voi kirjautua sisään
- Unix käyttäjäyhmän luonti tekniselle käyttäjälle, kehittäjien liittäminen tähän ryhmään
- Luodaan projektihakemistot ja käyttöoikeudet kuntoon hakemistoihin
- Käyttöoikeudet (rwx) muille käyttäjille projektihakemistoon

### Apache ja konfiguroinnit

- Apache2 asennus
- Virtual name based host tavalliselle sivustolle
- Apache2 virtual name base host wsgi ohjelmaa varten
- Apache2 oletusetusivu muutetaan
- Kotisivut on sallittu käyttäjien kotihakemistoista
- mod_wsgi Pythoon Flaskin ajoa varten
- Flask/wsgi ohjelmia voi muuttaa ja ajaa ilman sudo-oikeuksia

### Python ja Flask

- Python
- Flask
- Tarvittavat modulit Flask ohjelman ajamiseen, kuten python3-flask-sqlalchemy
- Curl testaamista varten

### Tietokanta
  
- PostgreSQL
- Databasen luonti
- Kantatunnuksen luonti

### Ohjelmien asennus
- Wsgi testisovellus
- Flask testisovellus, joka käyttää tietokantaa
- Sovellusten siirto oikeisiin projektihakemistoihin

## Testaus

Sovellus ja asennus voidaan testata selaimella. Jos asennus on samalle koneelle niin voidaan testata URL juhawsgi.example.com

Jos minion on toiella koneella, pitää muuttaa Apachen Virtual Name Based host konfiguraatoita..

### Testiohjelma

Testisovellus https://github.com/immonju1/flask-crud asennetaan osana tilaa.

## Tilan asentaminen

### Master

```
wget https://raw.githubusercontent.com/immonju1/salt/master/master.sh
chmod g+x master.sh
sudo ./master.sh
```

Ohjelma kysyy salasanan, joka annetaan Linux-käyttäjälle.

### Minion
```
wget https://raw.githubusercontent.com/immonju1/salt/master/minionsetup.sh
chmod g+x minionsetup.sh
sudo ./minionsetup.sh
```
Ohjelma kysyy Masterin IP-osoitteen, ja id:n joka annetaan Minionille.

Tämän jälkeen Masterilla

```
sudo salt-key -A
```
```
sudo salt '*' state.highstate
```


