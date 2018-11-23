{% set wsgi_user = pillar.get('wsgi_user', 'juhawsgi') %}
{% set dev_user = pillar.get('dev_user', 'mono') %}
{% set wsgi_group = pillar.get('wsgi_group', 'juhawsgi') %}
{% set dev_group = pillar.get('dev_group', 'mono') %}
{% set wsgi_file = pillar.get('wsgi_file', 'moi.wsgi') %}
{% set flask_file = pillar.get('flask_file', 'moi.py') %}


user_{{ wsgi_user }}:
  user.present:
    - name: {{ wsgi_user }}
    - shell: /bin/bash
    - fullname: Juha Immonen project user
    - password: $1$NjChq9zQ$sR6VAUrpJ4AjAoJvoEhvC/

user_{{ dev_user }}:
  user.present:
    - name: {{ dev_user }}
    - shell: /bin/bash
    - fullname: Juha Immonen test user
    - password: $1$NjChq9zQ$sR6VAUrpJ4AjAoJvoEhvC/

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

/home/{{ wsgi_user }}/public_wsgi:
  file.directory:
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 771

/home/{{ wsgi_user }}/public_wsgi/{{ wsgi_file }}:
  file.managed:
    - source: salt://users/{{ wsgi_file }}
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 764

/home/{{ wsgi_user }}/public_wsgi/{{ flask_file }}:
  file.managed:
    - source: salt://users/{{ flask_file }}
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 764
    - template: jinja
    - context:
      user: {{ wsgi_user }}
run_s_right:
  cmd.run:
    - name: chmod u=rwx,g=srwx,o=x /home/{{ wsgi_user }}/public_wsgi

/home/{{ wsgi_user }}/public_wsgi/templates:
  file.directory:
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 771

/home/{{ wsgi_user }}/public_wsgi/templates/base.html:
  file.managed:
    - source: salt://users/templates/base.html
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 764

/home/{{ wsgi_user }}/public_wsgi/templates/horses.html:
  file.managed:
    - source: salt://users/templates/horses.html
    - user: {{ wsgi_user }}
    - group: {{ wsgi_group }}
    - mode: 764



