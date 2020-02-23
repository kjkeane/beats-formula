# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import beats with context %}

include:
  - {{ sls_config_file }}

{%- if salt['pillar.get']('beats:filebeat:config', {}) %}
filebeat-service-running-service-running:
  service.running:
    - name: filebeat
    - enable: True
    - require:
      - file: filebeat-config-file-file-serialize
{%- endif %}

{%- if salt['pillar.get']('beats:metricbeat:config', {}) %}
metricbeat-service-running-service-running:
  service.running:
    - name: metricbeat
    - enable: True
    - require:
      - file: filebeat-config-file-file-serialize
{%- endif %}

{%- if salt['pillar.get']('beats:packetbeat:config', {}) %}
packetbeat-service-running-service-running:
  service.running:
    - name: packetbeat
    - enable: True
    - require:
      - file: packetbeat-config-file-file-serialize
{%- endif %}
