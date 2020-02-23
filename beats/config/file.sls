# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import beats with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{%- if salt['pillar.get']('beats:filebeat:config', {}) %}
filebeat-config-file-file-serialize:
  file.serialize:
    - name: /etc/filebeat/filebeat.yml
    - dataset_pillar: 'beats:filebeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if salt['pillar.get']('beats:metricbeat:config', {}) %}
metricbeat-config-file-file-serialize:
  file.serialize:
    - name: /etc/metricbeat/metricbeat.yml
    - dataset_pillar: 'beats:metricbeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if salt['pillar.get']('beats:auditbeat:config', {}) %}
auditbeat-config-file-file-serialize:
  file.serialize:
    - name: {{ beats.audiobeat.config }}
    - dataset_pillar: 'beats:audiobeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if salt['pillar.get']('beats:packetbeat:config', {}) %}
packebeat-config-file-file-serialize:
  file.serialize:
    - name: /etc/packetbeat/packetbeat.yml
    - dataset_pillar: 'beats:packetbeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if salt['pillar.get']('beats:heartbeat:config', {}) %}
heartbeat-config-file-file-serialize:
  file.serialize:
    - name: {{ beats.heartbeat.config }}
    - dataset_pillar: 'beats:heartbeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if salt['pillar.get']('beats:community:journalbeat:config', {}) %}
journalbeat-config-file-file-serialize:
  file.serialize:
    - name: {{ beats.journalbeat.config }}
    - dataset_pillar: 'beats:community:journalbeat:config'
    - formatter: yaml
    - mode: '0644'
    - user: root
    - group: root
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}
