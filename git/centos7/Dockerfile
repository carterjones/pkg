FROM carterjones/rpm-builder:latest

ARG VERSION

RUN mkdir -p /build/git
RUN curl -Lo /build/git/git.tgz "https://github.com/git/git/archive/v${VERSION}.tar.gz"
RUN cd /build/git && tar -xf git.tgz
RUN mv "/build/git/git-${VERSION}" /build/git/git
RUN yum install -y curl-devel
RUN cd /build/git/git && make configure
RUN cd /build/git/git && ./configure
RUN cd /build/git/git && make
