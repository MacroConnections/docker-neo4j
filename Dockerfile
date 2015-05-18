## Neo4J dependency: java
## get java from official repo
from java:latest
maintainer Manuel Aristaran, arista@mit.edu

## install neo4j according to http://www.neo4j.org/download/linux
# Import neo4j signing key
# Create an apt sources.list file
# Find out about the files in neo4j repo ; install neo4j community edition

run wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - && \
    echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list && \
    apt-get update ; apt-get install neo4j -y

add plugins/* /var/lib/neo4j/plugins/

add launch.sh /
run chmod +x /launch.sh && \
    apt-get clean && \
    sed -i "s|remote_shell_enabled=.+|remote_shell_enabled=true|g" /var/lib/neo4j/conf/neo4j.properties && \
    sed -i "s|data/graph.db|/opt/data/graph.db|g" /var/lib/neo4j/conf/neo4j-server.properties && \
    sed -i "s|dbms.security.auth_enabled=.+|dbms.security.auth_enabled=false|g" /var/lib/neo4j/conf/neo4j-server.properties && \
    echo "remote_shell_host=0.0.0.0" >> /var/lib/neo4j/conf/neo4j.properties

# dbms.security.auth_enabled=false

# expose REST and shell server ports
expose 7474
expose 1337

workdir /etc/neo4j

## entrypoint
cmd ["/bin/bash", "-c", "/launch.sh"]
