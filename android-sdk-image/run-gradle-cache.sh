#!/bin/bash
docker run -d -p 2222:22 -v $(pwd)/gradle/caches:/root/.gradle/caches --name android-sdk android-sdk
