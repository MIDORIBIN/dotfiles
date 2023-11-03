FROM ubuntu:22.04

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
        curl \
        vim

# ユーザーを作成
ENV USER=hoge
ARG UID=1000
RUN useradd -m -u ${UID} ${USER}
USER ${UID}

CMD [ "bash" ]
