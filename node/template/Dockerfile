# syntax=<%= docker_syntax %>

<%= generation_messages -%>

########## Node image ##################
FROM <%= base_image %>
LABEL com.get-bridge.image.authors="get-brige"

USER root
WORKDIR /usr/src/app

ENV NODE_MAJOR <%= node_major %>
ENV NODE_VERSION <%= node_version %>
ENV NPM_VERSION <%= npm_version %>
<% if flavor == 'yarn' -%>
ENV YARN_VERSION <%= yarn_version %>
<% end -%>

RUN <<EOT
#/usr/bin/env bash
  set -exu
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt-get update
  apt-get install --yes --no-install-recommends \
    gnupg
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | apt-key add -
  echo "deb https://deb.nodesource.com/node_<%= node_major %>.x <%= distribution_code_name %> main" \
    > /etc/apt/sources.list.d/nodesource.list
  apt-get update
  apt-get install --yes --no-install-recommends \
    nodejs
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  npm install --global "npm@${NPM_VERSION}"
<% if flavor == 'yarn' -%>
  npm install --global "yarn@${YARN_VERSION}"
<% end -%>
  rm -rf /root/.npm/_cacache
  npm cache clean --force
<% if flavor == 'fat' -%>
  # Install build dependencies for fat image, NOTE: fat image is NOT meant to be deployed to production
  apt-get update
  apt-get install --yes --no-install-recommends \
    build-essential
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
<% end -%>
  # Check that node commands work
  [ "$(command -v node)" = '/usr/bin/node' ]
  [ "$(command -v npm)" = '/usr/bin/npm' ]
  node -v
  npm -v
<% if flavor == 'yarn' -%>
  [ "$(command -v yarn)" = '/usr/bin/yarn' ]
  yarn -v
<% end -%>
EOT

USER docker
