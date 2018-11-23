{% set wsgi_group = pillar.get('wsgi_group', 'juhawsgi') %}
{% set dev_user = pillar.get('dev_user', 'mono') %}


add_group:
  group.present:
    - name: {{ wsgi_group }}
    - addusers:
      - {{ dev_user }}

