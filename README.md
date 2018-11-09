# Pieniä kokeluita Saltilla
Tämä on harjoittelua palvelintenhallinta-kurssille. Samalla tämä on kurssin harjoitus 3 vastaus.

Tavoitteena saada lopulta flask-ympäristö asennettua palvelimelle.

## Käyttäjätarina
Sovelluskehittäjänä haluan, että minulla on tuotantoa vastaava Python Flask ympäristö, jotta voin testata sovellustani oikeassa ympäristössä.

## Hyväksyntäkriteerit:

Salt asentaa seuraavat asiat

### Käyttäjät ja hakemistot

- Käyttäjätunnus kehittäjälle
- Tekninen käyttäjä projektille, jolla ei voi kirjautua sisään
- Ryhmän luonti tekniselle käyttäjälle
- Luodaan projektihakemistot ja käyttöoikeudet kuntoon
- Käyttöoikeudet (rwx) muille käyttäjille projektihakemistoon, liitetään aiemmin luotuun ryhmään

### Apache ja konfiguroinnit

- Apache2 asennus
- Virtual name based host
- Apache2 virtual name base host wsgi:lle
- Apache restart tapahtuu automaattiseti kun koodia päivitetään?
- Apache2 oletusetusivu on muutettu
- Kotisivut on sallittu käyttäjien kotihakemistoista
- mod_wsgi Pythoon Flaskin ajoa varten

### Python ja Flask

- Python
- Flask
- Curl

### Tietokanta
  
- PostgreSQL
- Kantatunnus sovellukselle

### Ohjelmien asennus
- Wsgi testisovellus
- Flask testisovellus, joka käyttää tietokantaa
- Sovelluksen siirto oikeisiin projketihakemistoihin

### Testaus
Sovellus ja asennus voidaan testata selaimella. Jos asennus on samalle koneelle niin voidaan testata URL juhawsgi.example.com

## Eteneminen
Tehdään ja testataan pienissä paloissa

