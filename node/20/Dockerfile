# syntax=docker/dockerfile:1.4


########## Node image ##################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core
LABEL com.get-bridge.image.authors="get-brige"

USER root
WORKDIR /usr/src/app

ENV NODE_MAJOR 20
ENV NODE_VERSION 20.2.0
ENV NPM_VERSION 9.6.6
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
  echo "deb https://deb.nodesource.com/node_20.x jammy main" \
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
  [ "$(command -v yarn)" = '/usr/bin/yarn' ]
  node -v
  npm -v
  yarn -v
EOT

USER docker
