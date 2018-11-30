{% set wsgi_user = pillar.get('wsgi_user', 'juhawsgi') %}
{% set dev_user = pillar.get('dev_user', 'mono') %}
{% set wsgi_group = pillar.get('wsgi_group', 'juhawsgi') %}
{% set dev_group = pillar.get('dev_group', 'mono') %}
{% set wsgi_file = pillar.get('wsgi_file', 'moi.wsgi') %}
{% set flask_file = pillar.get('flask_file', 'moi.py') %}
{% set pw = pillar.get('pw') %}

git:
  pkg.installed

user_{{ wsgi_user }}:
  user.present:
    - name: {{ wsgi_user }}
    - shell: /bin/bash
    - fullname: Juha Immonen project user

user_{{ dev_user }}:
  user.present:
    - name: {{ dev_user }}
    - shell: /bin/bash
    - fullname: Juha Immonen test user
    - password: {{ pw }}

/home/{{ dev_user }}/public_html:
  file.directory:
    - user: {{ dev_user }}
    - group: {{ dev_group }}
    - mode: 755

/home/{{ dev_user }}/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
    - user:  {{ dev_user }}
    - group:  {{ dev_user }}
    - mode: 755
    - template: jinja
    - context:
      user: {{ dev_user }}

/home/{{ wsgi_user }}:
  file.directory:
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 711

repo_clone:
  cmd.run:
    - name: git clone https://github.com/immonju1/flask-crud.git
    - user: {{ dev_user }}
    - unless: test -d /home/{{ dev_user }}/flask-crud 
    - require:
      - pkg: git 

create_public_wsgi:
  file:
    - symlink
    - name: /srv/salt/users/public_wsgi
    - target: /home/{{ dev_user }}/flask-crud
    - force: True
    - user: {{ dev_user }}

/home/{{ wsgi_user }}/public_wsgi:
  file.recurse:
    - source: salt://users/public_wsgi
    - include_empty: True
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - file_mode: 764
    - dir_mode: 711

run_s_right:
  cmd.run:
    - name: chmod u=rwx,g=srwx,o=x /home/{{ wsgi_user }}/public_wsgi



