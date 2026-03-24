FROM ubuntu:24.04

RUN sed -i.bak -E '/^URIs:/ { \
    N; /Suites:.*-security/! { \
      s@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@http://ftp.udx.icscoe.jp/Linux/ubuntu/@; \
      s@http://(jp\.)?ports\.ubuntu\.com/ubuntu-ports/?@http://ftp.udx.icscoe.jp/Linux/ubuntu-ports/@; \
    } \
  }' /etc/apt/sources.list.d/ubuntu.sources \
 && apt-get update && apt-get install -y \
        curl \
        vim \
        zsh \
        git

RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
 && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Setting dotfiles
COPY . /root/.local/share/chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /root/.local/bin apply \
 && zsh ~/.zshrc; zsh ~/.zshrc; exit 0

COPY dev/startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD [ "/startup.sh" ]
