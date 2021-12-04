FROM ubuntu:18.04

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
        curl \
        docker.io \
        make \
        vim \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./install_rcm.sh .
RUN bash ./install_rcm.sh

# ユーザーを作成
ENV USER=hoge
ARG UID=1000
ARG DOCKER_GROUP_ID=1001
RUN useradd -m -u ${UID} ${USER} \
 && groupmod -g ${DOCKER_GROUP_ID} docker \
 && usermod -aG docker ${USER}
USER ${UID}

CMD [ "bash" ]
