# MariaDB database password

dbpass:
  master.example.org : 6OohdOeVgMYW
  slave.example.org : yc2NIwk7_TVY

db_password: "{{ dbpass[inventory_hostname] }}"

# HAProxy stats user

haproxystatsuser:
  master.example.org : mystatsuser
  slave.example.org : mystatsuser

haproxy_stats_user: "{{ haproxystatsuser[inventory_hostname] }}"

# HAProxy stats password

haproxystatspass:
  master.example.org : mystatsuser 
  slave.example.org : mystatsuser

haproxy_stats_password: "{{ haproxystatspass[inventory_hostname] }}"
