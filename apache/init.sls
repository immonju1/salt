{% set wsgi_user = pillar.get('wsgi_user', 'juhawsgi') %}
{% set dev_user = pillar.get('dev_user', 'mono') %}
{% set wsgi_group = pillar.get('wsgi_group', 'juhawsgi') %}
{% set dev_group = pillar.get('dev_group', 'mono') %}
{% set wsgi_file = pillar.get('wsgi_file', 'moi.wsgi') %}
{% set flask_file = pillar.get('flask_file', 'moi.py') %}

apache2:
  pkg.installed:
    - pkgs:
      - apache2
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
    - template: jinja
    - context:
      user: {{ dev_user }}

/etc/apache2/sites-available/juhawsgi.example.com.conf:
  file.managed:
    - source: salt://apache/juhawsgi.example.com.conf
    - template: jinja
    - context:
      user: {{ wsgi_user }}
      file: {{ wsgi_file }}
      group: {{ wsgi_group }}

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

