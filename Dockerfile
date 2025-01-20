FROM ubuntu:22.04@sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97

# zsh install
RUN  apt-get update &&  apt-get install -y zsh git vim rsync zip

SHELL ["/bin/zsh", "-c"]

# zim install
RUN curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

RUN sh -c "$(curl -fsLS get.chezmoi.io)"
RUN mv ~/bin/chezmoi /usr/local/bin/chezmoi
RUN chezmoi init --apply https://github.com/walnuts1018/dotfiles
