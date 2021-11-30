# tmux
FROM debian:buster-slim AS tmux

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gcc \
        gcc-multilib \
        make \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY build/build_tmux.sh .
COPY build/libevent-2.1.12-stable.tar.gz .
COPY build/musl-1.2.2.tar.gz .
COPY build/ncurses-6.2.tar.gz .
RUN ./build_tmux.sh "${HOME}/local"


# bat and exa
FROM rust:1.56.1-slim-buster AS bat_exa

RUN cargo install --locked \
        bat \
        exa


# micro
FROM debian:buster-slim AS micro

RUN  apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && cd /root \
 && curl https://getmic.ro | bash


# bash-completion
FROM debian:buster-slim AS bash-completion
RUN  apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        xz-utils \
        make \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

ARG VERSION=2.11
RUN curl -OL https://github.com/scop/bash-completion/releases/download/${VERSION}/bash-completion-${VERSION}.tar.xz \
 && tar Jxf bash-completion-${VERSION}.tar.xz \
 && cd bash-completion-${VERSION} \
 && ./configure --prefix=${HOME}/local \
 && make \
 && make install


# base
FROM debian:buster-slim
ENV PATH=/root/local/bin/:${PATH}
COPY --from=tmux            /root/local/bin/tmux               /root/local/bin/
COPY --from=bat_exa         /usr/local/cargo/bin/exa           /root/local/bin/
COPY --from=bat_exa         /usr/local/cargo/bin/bat           /root/local/bin/
COPY --from=micro           /root/micro                        /root/local/bin/
COPY --from=bash-completion /root/local/share/bash-completion/ /root/local/share/bash-completion/
