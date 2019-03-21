FROM carterjones/rpm-builder:latest

ARG VERSION

RUN mkdir -p /build/zsh
RUN curl -Lo /build/zsh/zsh.tgz "https://github.com/zsh-users/zsh/archive/zsh-${VERSION}.tar.gz"
RUN cd /build/zsh && tar -xf zsh.tgz
RUN mv "/build/zsh/zsh-zsh-${VERSION}" /build/zsh/zsh
RUN cd /build/zsh/zsh && ./Util/preconfig
RUN cd /build/zsh/zsh && ./configure --with-tcsetpgrp
RUN cd /build/zsh/zsh && make
