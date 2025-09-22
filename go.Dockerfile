FROM golang:1.25.1-trixie
WORKDIR /root
USER root

ENV ZIM_HOME=/root/.zim

# zsh install
RUN apt-get -y update && apt-get upgrade -y && apt-get install -y zsh git vim rsync zip ca-certificates

SHELL ["/bin/zsh", "-c"]

# zim install
RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/ed996bec519610a171a2c56dc14f324e9cc10281/install.zsh | zsh

RUN sh -c "$(curl -fsLS get.chezmoi.io)"
RUN mv ./bin/chezmoi /usr/local/bin/chezmoi
RUN chezmoi init --apply https://github.com/walnuts1018/dotfiles
RUN rm .gitconfig

RUN go install golang.org/x/tools/gopls@v0.20.0
RUN go install github.com/cweill/gotests/gotests@v1.6.0
RUN go install github.com/fatih/gomodifytags@v1.17.0
RUN go install github.com/josharian/impl@latest
RUN go install github.com/haya14busa/goplay/cmd/goplay@v1.0.0
RUN go install github.com/go-delve/delve/cmd/dlv@v1.25.2
RUN go install honnef.co/go/tools/cmd/staticcheck@v0.6.1

CMD ["/bin/zsh"]
