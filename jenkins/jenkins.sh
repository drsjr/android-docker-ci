#!/bin/bash

docker run -p 8080:8080 -v $(pwd)/jenkins_home:/var/jenkins_home --name jenkins jenkins/jenkins:lts-alpine
