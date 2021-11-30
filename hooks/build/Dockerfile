# bash-completion
FROM debian:buster-slim AS bash-completion

ARG VERSION=2.11

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        xz-utils \
        make \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && curl -OL https://github.com/scop/bash-completion/releases/download/${VERSION}/bash-completion-${VERSION}.tar.xz \
 && tar Jxf bash-completion-${VERSION}.tar.xz \
 && cd bash-completion-${VERSION} \
 && ./configure --prefix=${HOME}/local \
 && make \
 && make install


# bat
FROM debian:buster-slim AS bat

ARG VERSION=0.18.3

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && curl -OL https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_amd64.deb \
 && dpkg -i bat_${VERSION}_amd64.deb


# exa
FROM debian:buster-slim AS exa

ARG VERSION=0.10.1

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && curl -OL https://github.com/ogham/exa/releases/download/v${VERSION}/exa-linux-x86_64-v${VERSION}.zip \
 && unzip exa-linux-x86_64-v${VERSION}.zip

# micro
FROM debian:buster-slim AS micro

COPY build/micro.sh .

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && ./micro.sh


# tmux
FROM debian:buster-slim AS tmux

COPY build/build_tmux.sh .
COPY build/libevent-2.1.12-stable.tar.gz .
COPY build/musl-1.2.2.tar.gz .
COPY build/ncurses-6.2.tar.gz .

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gcc \
        gcc-multilib \
        make \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && ./build_tmux.sh "${HOME}/local"

# base
FROM debian:buster-slim

ENV PATH=/root/local/bin/:${PATH}

COPY --from=bash-completion /root/local/share/bash-completion/ /root/local/share/bash-completion/
COPY --from=bat             /usr/bin/bat                       /root/local/bin/
COPY --from=exa             /bin/exa                           /root/local/bin/
COPY --from=micro           /micro                             /root/local/bin/
COPY --from=tmux            /root/local/bin/tmux               /root/local/bin/
