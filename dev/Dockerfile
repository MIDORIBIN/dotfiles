FROM ubuntu:18.04

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
        curl \
        docker.io \
        make \
        vim

# ユーザーを作成
ARG UID=1000
ARG DOCKER_GROUP_ID=1001
RUN useradd -m -u ${UID} hoge \
 && groupmod -g ${DOCKER_GROUP_ID} docker \
 && usermod -aG docker hoge
USER ${UID}
ENV USER=hoge

CMD [ "bash" ]
