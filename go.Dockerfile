FROM golang:1.25.1-bookworm

RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get -y update && apt-get upgrade -y && apt-get install -y sudo zsh git vim rsync zip ca-certificates

RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

RUN groupadd -g 1000 vscode \
    && useradd -s /bin/zsh -u 1000 -g vscode -m vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV WORKDIR=/home/vscode
WORKDIR ${WORKDIR}
USER vscode

SHELL ["/bin/zsh", "-c"]

ENV ZIM_HOME=${WORKDIR}/.zim

# zim install
RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/ed996bec519610a171a2c56dc14f324e9cc10281/install.zsh | zsh

RUN chezmoi init --apply https://github.com/walnuts1018/dotfiles
RUN rm ~/.gitconfig

RUN go install golang.org/x/tools/gopls@v0.20.0
RUN go install github.com/cweill/gotests/gotests@v1.6.0
RUN go install github.com/fatih/gomodifytags@v1.17.0
RUN go install github.com/josharian/impl@latest
RUN go install github.com/haya14busa/goplay/cmd/goplay@v1.0.0
RUN go install github.com/go-delve/delve/cmd/dlv@v1.25.2
RUN go install honnef.co/go/tools/cmd/staticcheck@v0.6.1

CMD ["/bin/zsh"]
