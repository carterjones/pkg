#!/bin/bash
set -euxo pipefail

# Install dependencies.
yum install -y \
    libtiff \
    libpng \
    giflib \
    libXpm \
    libXaw \
    gnutls

# Install emacs.
pushd /tmp
curl -Lo emacs.tgz https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/emacs/emacs-26.1.92.tar.gz
tar -xf emacs.tgz -C /

# Make sure it loads.
emacs --help
