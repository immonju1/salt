postgresql:
  pkg.installed

juhawsgi_user:
  postgres_user.present:
    - name: juhawsgi

juhawsgi:
    postgres_database.present:
    - owner: juhawsgi
