# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import beats with context %}

{%- if beats.use_upstream_repo %}
{%- if salt['grains.get']('os_family') == 'Debian' %}
beats-pkgrepo-managed:
    pkg.installed:
        - name: apt-transport-https
    pkgrepo.managed:
        - name: deb https://artifacts.elastic.co/packages/{{ beats.version }}.x/apt stable main
        - file: /etc/apt/sources.list.d/elastic.list
        - gpgcheck: 1
        - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
        - require:
            - pkg: apt-transport-https
{%- elif salt['grains.get']('os_family') == 'RedHat' %}
beats-pkgrepo-managed:
    pkgrepo.managed:
        - name: elastic
        - humanname: "Elastic repository for {{ beats.version }}.x packages"
        - baseurl: https://artifacts.elastic.co/packages/{{ beats.version }}.x/yum
        - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch
        - gpgcheck: 1
        - disabled: False
{%- endif %}
{%- endif %}

{%- if salt['pillar.get']('beats:filebeat:config', {} ) %}
filebeat-package-install-pkg-installed:
  pkg.installed:
    - name: filebeat
    - require:
      - pkgrepo: beats-pkgrepo-managed
{%- endif %}

{%- if salt['pillar.get']('beats:metricbeat:config', {} ) %}
metricbeat-package-install-pkg-installed:
  pkg.installed:
    - name: metricbeat
    - require:
      - pkgrepo: beats-pkgrepo-managed
{%- endif %}

{%- if salt['pillar.get']('beats:packetbeat:config', {} ) %}
packetbeat-package-install-pkg-installed:
  pkg.installed:
    - name: packetbeat
    - require:
      - pkgrepo: beats-pkgrepo-managed
{%- endif %}
