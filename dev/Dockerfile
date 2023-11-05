FROM ubuntu:22.04

RUN sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
        curl \
        vim \
        zsh \
        git

# Install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /root/.local/bin

# Setting dotfiles
COPY . /root/.local/share/chezmoi
RUN /root/.local/bin/chezmoi apply
RUN zsh ~/.zshrc; zsh ~/.zshrc; exit 0

CMD [ "zsh" ]
