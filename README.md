# Python Flask ympäristön asennus palvelimille Saltilla
Tämä on miniprojekti palvelintenhallintakurssille.

Tavoitteena saada lopulta flask-ympäristö asennettua palvelimelle.

Tehtävän dokumentaatio https://github.com/immonju1/salt/tree/master/docs

## Käyttäjätarina

Koodaajana haluan, että minulla on tuotantoa vastaava Python Flask ympäristö, jotta voin testata sovellustani oikeassa ympäristössä.

## Hyväksyntäkriteerit:

Salt asentaa seuraavat asiat

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
- Curl testaamista varten

### Tietokanta
  
- PostgreSQL
- Kantatunnuksen luonti

### Ohjelmien asennus
- Wsgi testisovellus
- Flask testisovellus, joka käyttää tietokantaa
- Sovellusten siirto oikeisiin projektihakemistoihin

### Testaus
Sovellus ja asennus voidaan testata selaimella. Jos asennus on samalle koneelle niin voidaan testata URL juhawsgi.example.com

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


