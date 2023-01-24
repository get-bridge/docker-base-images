# syntax=docker/dockerfile:1.4

# GENERATED FILE, DO NOT MODIFY!
# To update this file please edit the relevant template and run the generation
# task `rake generate:ruby-passenger`

########## Ruby Passenger image ##########################
FROM 127178877223.dkr.ecr.us-east-2.amazonaws.com/get-bridge/ruby:2.7-fat as build
LABEL com.get-bridge.image.authors="get-bridge"

USER root
ENV PASSENGER_VERSION 6.0.15

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  pushd /opt
  curl -Ls https://github.com/phusion/passenger/archive/refs/tags/release-${PASSENGER_VERSION}.tar.gz | tar zxf -
  echo "PATH=/opt/passenger-release-${PASSENGER_VERSION}/bin:$PATH" > /etc/bash.bashrc
  source /etc/bash.bashrc
  gem install rack
  passenger-install-nginx-module
  passenger-config validate-install
  popd
EOT

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  mkdir -p /usr/src/nginx/conf.d
  mkdir -p /usr/src/nginx/location.d
  mkdir -p /usr/src/nginx/main.d
  mkdir -p /usr/src/nginx/server.d
  ln -sf /dev/stdout /opt/nginx/logs/access.log
  ln -sf /dev/stderr /opt/nginx/logs/error.log
  chown docker:docker -R /usr/src/nginx
EOT

COPY entrypoint /usr/src/entrypoint
COPY nginx.conf.erb /usr/src/nginx/nginx.conf.erb
COPY main.d/* /usr/src/nginx/main.d/

USER docker

EXPOSE 80
CMD ["/tini", "--", "/usr/src/entrypoint"]
