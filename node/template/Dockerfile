# syntax=<%= docker_syntax %>

<%= generation_message %>

########## Node image ##########################
# https://github.com/nodejs/docker-node/blob/48af72ca53ea2836009970e45ed3e4fcb237f3b4/8/core/Dockerfile
FROM <%= base_image %>
LABEL com.get-bridge.image.authors="get-bridge"

USER root

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  apt-get update
  apt-get install -y --no-install-recommends gnupg parallel
  # Import gpg keys for node.js releasers
  <% if node_major >= 12 %>
  # via https://github.com/nodejs/node/tree/dd167ff0ee90fa47e0d92c514c20f1aaa53363bc#release-keys
  # use parallel to fetch keys faster
  parallel gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys ::: \
    4ED778F539E3634C779C87C6D7062848A1AB005C \
    141F07595B7B3FFE74309A937405533BE57C7D57 \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    74F12602B6F1C4E913FAA37AD3A89613643B6201 \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    61FC681DFB92A079F1685E77973F295594EC4689 \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
    C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
    108F52B48DB57BB0CC439B2997B01419BD92F80A \
    B9E2F5981AA6E0CD28160D9FF13993A75599653C
  <% else %>
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
  <% end %>

EOT

ENV NODE_MAJOR <%= node_major %>
ENV NODE_VERSION <%= node_version %>
# TODO: need to export npm version programmatically
# ENV NPM_VERSION 5.6.0
ENV LANG en_US.utf-8

RUN <<EOT
#!/usr/bin/env bash
  set -eux

  # set up working directory
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app

  # test arch compatability
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
  # hold build dependencies in a variable to make cleanup easy
  buildDeps='ca-certificates curl xz-utils'

  # install node
  apt-get update
  apt-get install -y --no-install-recommends $buildDeps
  curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz"
  curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"
  gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc
  grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c -
  tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
  rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

  # cleanup apt
  apt-get purge -y --auto-remove $buildDeps

<% if flavor == 'fat' %>
  # install build dependencies for fat image, NOTE: fat image is NOT meant to be deployed to production
  apt-get update
  apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    xz-utils
<% end %>

  # cleanup disk
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
