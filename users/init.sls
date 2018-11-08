user_juhawsgi:
  user.present:
    - name: juhawsgi
    - fullaname: Juha Immonen project user

user_mono:
  user.present:
    - name: mono
    - fullname: Juha Immonen test user
    - password: $1$87VRLq2n$thW8VOLJ4f1pe/YbxlHrA/

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

