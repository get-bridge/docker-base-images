# syntax=docker/dockerfile:1.4


########## Node image ##################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core
LABEL com.get-bridge.image.authors="get-brige"

USER root
WORKDIR /usr/src/app

ENV NODE_MAJOR 18
ENV NODE_VERSION 18.15.0
ENV NPM_VERSION 9.5.0

RUN <<EOT
#/usr/bin/env bash
  set -exu
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt-get update
  apt-get install --yes --no-install-recommends \
    gnupg
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -
  echo "deb https://deb.nodesource.com/node_18.x jammy main" \
    > /etc/apt/sources.list.d/nodesource.list
  apt-get update
  apt-get install --yes --no-install-recommends \
    nodejs
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  npm install --global "npm@${NPM_VERSION}"
  rm -rf /root/.npm/_cacache
  npm cache clean --force
  # Install build dependencies for fat image, NOTE: fat image is NOT meant to be deployed to production
  apt-get update
  apt-get install --yes --no-install-recommends \
    build-essential
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  # Check that node commands work
  [ "$(command -v node)" = '/usr/bin/node' ]
  [ "$(command -v npm)" = '/usr/bin/npm' ]
  node -v
  npm -v
EOT

USER docker
