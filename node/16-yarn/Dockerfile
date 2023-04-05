# syntax=docker/dockerfile:1.4


########## Node image ##################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core
LABEL com.get-bridge.image.authors="get-brige"

USER root
WORKDIR /usr/src/app

ENV NODE_MAJOR 16
ENV NODE_VERSION 16.20.0
ENV NPM_VERSION 8.19.4
ENV YARN_VERSION 1.22.19

RUN <<EOT
#/usr/bin/env bash
  set -exu
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt-get update
  apt-get install --yes --no-install-recommends \
    gnupg
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -
  echo "deb https://deb.nodesource.com/node_16.x jammy main" \
    > /etc/apt/sources.list.d/nodesource.list
  apt-get update
  apt-get install --yes --no-install-recommends \
    nodejs
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  npm install --global "npm@${NPM_VERSION}"
  npm install --global "yarn@${YARN_VERSION}"
  rm -rf /root/.npm/_cacache
  npm cache clean --force
  # Check that node commands work
  [ "$(command -v node)" = '/usr/bin/node' ]
  [ "$(command -v npm)" = '/usr/bin/npm' ]
  node -v
  npm -v
  [ "$(command -v yarn)" = '/usr/bin/yarn' ]
  yarn -v
EOT

USER docker
