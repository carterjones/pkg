#!/bin/bash
set -euxo pipefail

# Install zsh.
pushd /tmp
curl -Lo zsh.tgz https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/zsh/zsh-5.7.1.tar.gz
tar -xf zsh.tgz -C /

# Make sure it loads.
zsh --help
