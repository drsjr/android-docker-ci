#!/bin/bash
docker run -d -p 80:80 -p 443:443 -v $(pwd)/distributions:/var/www/gradle.org/public_html/distributions --name gradle-server gradle-server
