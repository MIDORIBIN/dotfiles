#!/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

tty

. config

OUTPUT=${HOME}/local2
CONTAINER_NAME="dotfile_builder"


# 準備
function preprocess () {
  docker_build
  docker_run
  mkdir -p ${OUTPUT}/share
  mkdir -p ${OUTPUT}/bin
}

function docker_build () {
  docker build -t dotfile:build .
}

function docker_run () {
  docker create -it --name ${CONTAINER_NAME} dotfile:build
  docker start ${CONTAINER_NAME}
}

# 処理
function process () {
  if ${INSTALL_BASH_COMPLETION}; then
    install_bash_completion
  fi

  if ${INSTALL_BAT}; then
    install_bat
  fi

  if ${INSTALL_EXA}; then
    install_exa
  fi

  if ${INSTALL_MICRO}; then
    install_micro
  fi

  if ${INSTALL_TMUX}; then
    install_tmux
  fi
}

function install_bash_completion () {
  docker cp ${CONTAINER_NAME}:/usr/share/bash-completion ${OUTPUT}/share/
}

function install_bat () {
  BAT_VERSION=0.18.3
  docker exec -it ${CONTAINER_NAME} bash -c "\
    curl -OL https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb && \
    dpkg -i bat_${BAT_VERSION}_amd64.deb \
  "
  docker cp ${CONTAINER_NAME}:/usr/bin/bat ${OUTPUT}/bin/
}

function install_exa () {
  docker cp ${CONTAINER_NAME}:/usr/bin/exa ${OUTPUT}/bin/
}

function install_micro () {
  docker exec -it ${CONTAINER_NAME} /assets/micro.sh
  docker cp ${CONTAINER_NAME}:/micro ${OUTPUT}/bin/
}

function install_tmux () {
  docker exec -it ${CONTAINER_NAME} bash -c "\
    cd /assets && \
    ./build_tmux.sh \
  "
  docker cp ${CONTAINER_NAME}:/assets/out/bin/tmux ${OUTPUT}/bin/
}

# 後処理
function postprocess () {
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
}

preprocess
process
postprocess
