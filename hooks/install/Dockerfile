FROM debian:buster-slim

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        bash-completion \
        ca-certificates \
        curl \
        exa \
        gcc \
        gcc-multilib \
        make \
        unzip \
        xz-utils \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY assets assets
