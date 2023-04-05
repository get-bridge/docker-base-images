# syntax=docker/dockerfile:1.4


########## Node image ##################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:bionic
LABEL com.get-bridge.image.authors="get-brige"

USER root
WORKDIR /usr/src/app

ENV NODE_MAJOR 10
ENV NODE_VERSION 10.24.1
ENV NPM_VERSION 6.14.12

RUN <<EOT
#/usr/bin/env bash
  set -exu
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt-get update
  apt-get install --yes --no-install-recommends \
    gnupg
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -
  echo "deb https://deb.nodesource.com/node_10.x bionic main" \
    > /etc/apt/sources.list.d/nodesource.list
  apt-get update
  apt-get install --yes --no-install-recommends \
    nodejs
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  npm install --global "npm@${NPM_VERSION}"
  rm -rf /root/.npm/_cacache
  npm cache clean --force
  # Check that node commands work
  [ "$(command -v node)" = '/usr/bin/node' ]
  [ "$(command -v npm)" = '/usr/bin/npm' ]
  node -v
  npm -v
EOT

USER docker
