{% set wsgi_user = pillar.get('wsgi_user', 'juhawsgi') %}

postgresql:
  pkg.installed

juhawsgi_user:
  postgres_user.present:
    - name: {{ wsgi_user }}

juhawsgi:
    postgres_database.present:
    - owner: {{ wsgi_user }}
