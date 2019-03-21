FROM carterjones/rpm-builder:latest

ARG VERSION

RUN mkdir -p /build/emacs
RUN curl -Lo /build/emacs/emacs.tgz "https://github.com/emacs-mirror/emacs/archive/emacs-${VERSION}.tar.gz"
RUN cd /build/emacs && tar -xf emacs.tgz
RUN mv "/build/emacs/emacs-emacs-${VERSION}" /build/emacs/emacs
RUN cd /build/emacs/emacs && make configure
RUN cd /build/emacs/emacs && ./configure
RUN cd /build/emacs/emacs && make
