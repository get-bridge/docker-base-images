# syntax=docker/dockerfile:1.4

# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:java`

########## Java image ##########################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core
LABEL com.get-bridge.image.authors="get-bridge"

USER root

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt update
  apt install --yes --no-install-recommends \
    openjdk-11-jdk
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

  # Check that java commands work
  [ "$(command -v java)" = '/usr/bin/java' ]
  java --version
EOT

USER docker

WORKDIR /usr/src/app
