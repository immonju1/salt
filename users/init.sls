user_juhawsgi:
  user.present:
    - name: juhawsgi
    - fullname: Juha Immonen project user

user_mono:
  user.present:
    - name: mono
    - fullname: Juha Immonen test user
    - password: $1$NjChq9zQ$sR6VAUrpJ4AjAoJvoEhvC/

/home/mono/public_html:
  file.directory:
    - user: mono
    - group: mono
    - mode: 711

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

