[agiprxsrv]
master.example.org:22
slave.example.org:22

[agiprxsrv:vars]
# Hint: changes to serverdir (default '/opt/agiprx') need to be reflected in application.properties
serverdir=/opt/agiprx

# Hint: changes to agiprx ssh port (default '2223') need to be reflected in application.properties
agiprx_port=2223

# backend to use in haproxy as default backend
# haproxy_default_backend_ipport=138.201.254.249:80
haproxy_default_backend_ipport=[2a01:4f8:231:39c5:216:3eff:feac:e663]:80

# Hint: database password needs to be configured in secured-vars.yml
db_name=agiprx
db_user=agiprx

# Set debug option for remote debugging in development
# jdkdebugoptions=-agentlib:jdwp=transport=dt_socket,address=*:8000,server=y,suspend=n
jdkdebugoptions=

# AgiPrx JAR/release
agiprx_jar=agiprx-1.8.jar
