# syntax=<%= docker_syntax %>

<%= generation_message %>

########## Ruby image ##########################
FROM <%= base_image %>
LABEL com.get-bridge.image.authors="get-bridge"

USER root

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  mkdir -p /usr/src/app
  chown docker:docker /usr/src/app
  apt update
  apt install -qqy --no-install-recommends \
    bzip2 \
    libffi-dev \
    libgmp-dev \
    libssl-dev \
    libyaml-dev \
    procps \
    zlib1g-dev
  <% if ruby_major <= 3.0 -%>
  arch=$(dpkg --print-architecture)
  if [ "$arch" == "arm64" ]; then
    # Ruby versions older than or equal to 3.0 require an older version of openssl :| which is really annoying
    echo "deb http://ports.ubuntu.com/ubuntu-ports/ impish main restricted" >> /etc/apt/sources.list
    echo "deb http://ports.ubuntu.com/ubuntu-ports/ impish-updates main restricted" >> /etc/apt/sources.list
    echo "deb http://ports.ubuntu.com/ubuntu-ports/ impish-security main restricted" >> /etc/apt/sources.list
  else
    echo "deb http://archive.ubuntu.com/ubuntu/ impish main restricted" >> /etc/apt/sources.list
    echo "deb http://archive.ubuntu.com/ubuntu/ impish-updates main restricted" >> /etc/apt/sources.list
    echo "deb http://security.ubuntu.com/ubuntu/ impish-security main restricted" >> /etc/apt/sources.list
  fi
  apt update
  apt install -qqy --allow-downgrades \
    libssl-dev=1.1.1* \
    openssl=1.1.1*
  apt-mark hold \
    libssl-dev \
    libssl1.1 \
    openssl
  <% end -%>
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
EOT

# skip installing gem documentation
COPY <<-"EOT" /usr/local/etc/gemrc
install: --no-document
update: --no-document
EOT

ENV BUNDLER_VERSION <%= bundler_version %>
ENV LANG en_US.utf-8
ENV RUBYGEMS_VERSION <%= rubygems_version %>
ENV RUBY_DOWNLOAD_SHA256 <%= ruby_download_sha256 %>
ENV RUBY_MAJOR <%= ruby_major %>
ENV RUBY_VERSION <%= ruby_version %>

# NOTE: some of ruby's build scripts are written in ruby so we need to install ruby
# in order to compile ruby. We use apt-mark to uninstall packages we don't need.
#
# Adapted from https://github.com/docker-library/ruby/blob/master
RUN <<EOT
#!/usr/bin/env bash
  set -eux
  savedAptMark="$(apt-mark showmanual)"
  apt update
  apt install -qqy --no-install-recommends \
    autoconf \
    bison \
    dpkg-dev \
    g++ \
    gcc \
    libbz2-dev \
    libgdbm-compat-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libncurses-dev \
    libreadline-dev \
    libxml2-dev \
    libxslt-dev \
    make \
    ruby \
    wget \
    xz-utils
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
  curl -L https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz -o ruby.tar.xz
  echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum --check --strict
  mkdir -p /usr/src/ruby
  tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1
  rm ruby.tar.xz
  cd /usr/src/ruby
  # hack in "ENABLE_PATH_CHECK" disabling to suppress: warning: Insecure world writable dir
  sed -i 's/define ENABLE_PATH_CHECK 1/define ENABLE_PATH_CHECK 0/g' file.c
  autoconf
  # Should return something like `arm64`
  arch=$(dpkg --print-architecture)
  # Should return something like `linux-gnu`
  operating_system=$(uname -o | awk '{split($0,a,"/"); print tolower(a[2])"-"tolower(a[1])}')
  ./configure --build="$arch-$operating_system" --disable-install-doc --enable-shared
  make -j "$(nproc)"
  make install
  apt-mark auto '.*' > /dev/null
  apt-mark manual $savedAptMark > /dev/null
  find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' \
          | awk '/=>/ { print $(NF-1) }' \
          | sort -u \
          | grep -vE '^/usr/local/lib/' \
          | xargs -r dpkg-query --search \
          | cut -d: -f1 \
          | sort -u \
          | xargs -r apt-mark manual
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
  cd /
  rm -r /usr/src/ruby
  # Ensure we have removed the system ruby
  if dpkg -l | grep -i ruby; then exit 1; fi;
  # Update rubygems and bundler
  gem update  --no-document --system $RUBYGEMS_VERSION
  gem install --no-document bundler -v $BUNDLER_VERSION
  # Check that ruby commands work
  [ "$(command -v ruby)" = '/usr/local/bin/ruby' ]
  ruby --version
  gem --version
  bundle --version
EOT

# Set ruby defaults to docker user
USER docker

RUN <<EOT
#!/usr/bin/env bash
  set -eux
  echo 'gem: --no-document' >> /home/docker/.gemrc
  mkdir -p /home/docker/.gem/ruby/$RUBY_MAJOR.0/build_info \
           /home/docker/.gem/ruby/$RUBY_MAJOR.0/cache \
           /home/docker/.gem/ruby/$RUBY_MAJOR.0/doc \
           /home/docker/.gem/ruby/$RUBY_MAJOR.0/extensions \
           /home/docker/.gem/ruby/$RUBY_MAJOR.0/gems \
           /home/docker/.gem/ruby/$RUBY_MAJOR.0/specifications \
           /home/docker/.bundle

EOT

ENV GEM_HOME /home/docker/.gem/ruby/$RUBY_MAJOR.0
ENV BUNDLE_APP_CONFIG /home/docker/.bundle
ENV PATH $GEM_HOME/bin:$PATH
WORKDIR /usr/src/app

CMD [ "irb" ]
