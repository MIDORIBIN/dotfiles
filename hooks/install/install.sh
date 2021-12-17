#!/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

. config

OUTPUT=${HOME}/local
IMAGE_NAME="dotfile:build"
CONTAINER_NAME="dotfile_builder"


# 準備
function preprocess () {
  docker_build
  docker_run
  mkdir -p ${OUTPUT}/share
  mkdir -p ${OUTPUT}/bin
}

function docker_build () {
  docker build -t ${IMAGE_NAME} .
}

function docker_run () {
  docker create -it --name ${CONTAINER_NAME} ${IMAGE_NAME}
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
  docker exec ${CONTAINER_NAME} bash -c "\
    curl -OL https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb && \
    dpkg -i bat_${BAT_VERSION}_amd64.deb \
  "
  sleep 10
  check_file "/usr/bin/bat"
  docker cp ${CONTAINER_NAME}:/usr/bin/bat ${OUTPUT}/bin/
}

function install_exa () {
  docker cp ${CONTAINER_NAME}:/usr/bin/exa ${OUTPUT}/bin/
}

function install_micro () {
  docker exec ${CONTAINER_NAME} /assets/micro.sh
  sleep 40
  check_file "/micro"
  docker cp ${CONTAINER_NAME}:/micro ${OUTPUT}/bin/
}

function install_tmux () {
  docker exec ${CONTAINER_NAME} bash -c "\
    cd /assets && \
    ./build_tmux.sh \
  "
  sleep 40
  check_file "/assets/out/bin/tmux"
  docker cp ${CONTAINER_NAME}:/assets/out/bin/tmux ${OUTPUT}/bin/
}

# 後処理
function postprocess () {
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
  docker rmi ${IMAGE_NAME}
}

# 共通
function check_file () {
  for i in `seq 1 60`; do
    sleep 1
    if sh -c "docker exec -i ${CONTAINER_NAME} ls ${1}" > /dev/null 2>&1; then
      return
    fi
  done
  exit 1
}

preprocess
process
postprocess

# todo
# docker build の build argsで分岐させる
