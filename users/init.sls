user_juhawsgi:
  user.present:
    - name: juhawsgi
    - fullname: Juha Immonen project user

user_mono:
  user.present:
    - name: mono
    - fullname: Juha Immonen test user
    - password: salainen

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

