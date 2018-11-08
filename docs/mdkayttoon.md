
Halusin saada Markdown tiedoston pdf-formaattiin.

Ensin piti asentaa pandoc.

```
$ sudo apt install pandoc
$ pandoc kokeiluita.md -o git.pdf
```

Jotain kirjastoja puuttuu, joten googlella etsimään.

  pandoc: pdflatex not found. 
  pdflatex is needed for pdf output.

Pitää asentaa lisäkirjasto.

```
$ sudo apt-get install texlive-latex-base
```

Kokeilin pandoc:ia, mutta edelleen puuttuu jotain kirjastoja.

! Font T1/cmr/m/n/10=ecrm1000 at 10.0pt not loadable: Metric (TFM) file not fou
nd.

Asennetaan lisää kirjastoja lähteen 2 mukaan.

```
$ sudo apt-get install texlive-fonts-recommended
$ sudo apt-get install texlive-fonts-extra
```

Nyt pdf-tiedosto muodostuu.

```
$ pandoc kokeiluita.md -o git.pdf
```

Katsotaan pdf:n sisältö

```
$ okular git.pdf 
```

Ei onnistu. Pitää asentaa okular.

```
$ sudo apt install okular
```

Kokeillaan uudestaan ja toimii, okular aukeaa ja siinä näytetään teksti pdf-tiedossa.

Lähteet:

http://terokarvinen.com/2018/versionable-plain-text-reference-management-git-pandoc-and-bibtext


https://gist.github.com/rain1024/98dd5e2c6c8c28f9ea9d
