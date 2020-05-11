#!/bin/bash
docker cp gradle-server:/etc/apache2/ssl/apache.crt apache.crt && \
    docker cp apache.crt android-sdk:/home/apache.crt && \
    docker exec -it android-sdk bash -c '$JAVA_HOME/bin/keytool -import -trustcacerts -file /home/apache.crt -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt' && \
    docker exec -it android-sdk bash -c 'echo "192.168.1.184 services.gradle.org" >> /etc/hosts'