user_juhawsgi:
  user.present:
    - name: juhawsgi
    - shell: /bin/bash
    - fullname: Juha Immonen project user
    - password: $1$NjChq9zQ$sR6VAUrpJ4AjAoJvoEhvC/

user_mono:
  user.present:
    - name: mono
    - shell: /bin/bash
    - fullname: Juha Immonen test user
    - password: $1$NjChq9zQ$sR6VAUrpJ4AjAoJvoEhvC/

/home/mono/public_html:
  file.directory:
    - user: mono
    - group: mono
    - mode: 755

/home/mono/public_html/index.html:
  file.managed:
    - source: salt://users/index.html
    - user: mono
    - group: mono
    - mode: 755

/home/juhawsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 711

/home/juhawsgi/public_wsgi:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 771

/home/juhawsgi/public_wsgi/juha.wsgi:
  file.managed:
    - source: salt://users/juha.wsgi
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764

/home/juhawsgi/public_wsgi/moi.wsgi:
  file.managed:
    - source: salt://users/moi.wsgi
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764

/home/juhawsgi/public_wsgi/moi.py:
  file.managed:
    - source: salt://users/moi.py
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764

run_s_right:
  cmd.run:
    - name: chmod u=rwx,g=srwx,o=x /home/juhawsgi/public_wsgi

/home/juhawsgi/public_wsgi/templates:
  file.directory:
    - user: juhawsgi
    - group: juhawsgi
    - mode: 771

/home/juhawsgi/public_wsgi/templates/base.html:
  file.managed:
    - source: salt://users/templates/base.html
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764

/home/juhawsgi/public_wsgi/templates/horses.html:
  file.managed:
    - source: salt://users/templates/horses.html
    - user: juhawsgi
    - group: juhawsgi
    - mode: 764



