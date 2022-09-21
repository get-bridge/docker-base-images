# syntax=<%= docker_syntax %>

<%= generation_message -%>

########## Java image ##########################
FROM <%= registry %>/<%= base_image %>
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
