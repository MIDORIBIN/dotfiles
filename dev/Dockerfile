FROM ubuntu:22.04

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
        curl \
        vim \
        zsh \
        git

WORKDIR /root
ENV PATH=/root/bin:${PATH}
RUN sh -c "$(curl -fsLS get.chezmoi.io)"

COPY dev/startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD [ "/startup.sh" ]
