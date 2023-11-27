{% set os = salt['grains.get']('kernel').lower() %}
{% set env = salt['grains.get']('env').lower() %}
{% set project = salt['grains.get']('project') %}

{% if os == "linux" and env == "dev" or env == "uat" %}

lin-always-passes:
  test.succeed_without_changes:
    - name: lin_admin_ad_group_succeed
    

grep:
  cmd.run:
    - name: 'grep project /etc/salt/grains'

print_grain:
  cmd.run:
    - name: echo "{{ project }}"
  
backup:
  file.managed:
    - name: /etc/salt/grains
    - backup: minion
    - onchanges: grep
    - require: grep   

{% elif os == "windows" and env == "dev" or env == "uat" %}

win-always-passes:
  test.succeed_without_changes:
    - name: win_admin_ad_group_succeed

{% endif %}
