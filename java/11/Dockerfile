# syntax=docker/dockerfile:1.4

# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:java`

########## Java image ##########################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:jammy
LABEL com.get-bridge.image.authors="get-bridge"

USER root

RUN <<EOT
set -exu
apt-get update
apt-get install --yes --no-install-recommends openjdk-11-jdk
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
EOT

USER docker
