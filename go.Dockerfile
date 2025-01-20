FROM golang:1.23.5-bookworm

# zsh install
RUN  apt-get update &&  apt-get install -y zsh git vim rsync zip

SHELL ["/bin/zsh", "-c"]

# zim install
RUN curl -fsSL https://github.com/zimfw/zimfw/releases/download/v1.17.0/zimfw.zsh | zsh

RUN sh -c "$(curl -fsLS get.chezmoi.io)"
RUN mv ~/bin/chezmoi /usr/local/bin/chezmoi
RUN chezmoi init --apply https://github.com/walnuts1018/dotfiles

RUN go install golang.org/x/tools/gopls@v0.17.1
RUN go install github.com/cweill/gotests/gotests@v1.6.0
RUN go install github.com/fatih/gomodifytags@v1.17.0
RUN go install github.com/josharian/impl@
RUN go install github.com/haya14busa/goplay/cmd/goplay@latest
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest
