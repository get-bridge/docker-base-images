# syntax=docker/dockerfile:1.4

# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:node`

########## Node image ##########################
# https://github.com/nodejs/docker-node/blob/48af72ca53ea2836009970e45ed3e4fcb237f3b4/8/core/Dockerfile
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/core:latest
LABEL com.get-bridge.image.authors="get-bridge"

USER root

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  cp /etc/apt/sources.list /etc/apt/sources.list.bak
  sed -i 's/archive.ubuntu.com/la.mirrors.clouvider.net/g' /etc/apt/sources.list
  apt-get update
EOT

RUN <<EOT
#!/usr/bin/env bash
  apt-get install -y --no-install-recommends gnupg parallel
  # Import gpg keys for node.js releasers
  
  # Node v8.11 keys sourced from:
  # https://github.com/nodejs/docker-node/blob/48af72ca53ea2836009970e45ed3e4fcb237f3b4/8/stretch/Dockerfile#L21-L30
  # use parallel to fetch keys faster
  parallel gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys ::: \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600
  
EOT

ENV NODE_MAJOR 8.11
ENV NODE_VERSION 8.11.3
# node 8.11.3 comes prepackaged with npm 5.6.0
ENV NPM_VERSION 5.6.0
ENV LANG en_US.utf-8

RUN <<EOT
#!/usr/bin/env bash
  set -exu
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app

  ARCH= && dpkgArch="$(dpkg --print-architecture)"
  case "${dpkgArch##*-}" in
    amd64) ARCH='x64';;
    ppc64el) ARCH='ppc64le';;
    s390x) ARCH='s390x';;
    arm64) ARCH='arm64';;
    armhf) ARCH='armv7l';;
    i386) ARCH='x86';;
    *) echo "unsupported architecture"; exit 1 ;;
  esac

  apt-get update
  buildDeps='ca-certificates curl xz-utils'
  apt-get install -y --no-install-recommends $buildDeps
  curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz"
  curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"
  gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc
  grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c -
  tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
  rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

  apt-get purge -y --auto-remove $buildDeps


  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
  #  Check that node commands work
  test "$(command -v node)" = '/usr/local/bin/node'
  test "$(command -v npm)" = '/usr/local/bin/npm'
  node --version
  npm --version
EOT

USER docker

WORKDIR /usr/src/app

CMD [ "node -v" ]
