# Pieniä kokeluita Saltilla
Tämä on harjoittelua palvelintenhallinta-kurssille. Samalla tämä on kurssin harjoitus 3 vastaus.

Tavoitteena saada lopulta flask-ympäristö asennettua palvelimelle.

Muut tehtävän vastaukset https://github.com/immonju1/salt/tree/master/docs

## Käyttäjätarina
Sovelluskehittäjänä haluan, että minulla on tuotantoa vastaava Python Flask ympäristö, jotta voin testata sovellustani oikeassa ympäristössä.

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

## Eteneminen
Tehdään ja testataan pienissä paloissa

