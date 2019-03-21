#!/bin/bash
set -euxo pipefail

# Install git.
pushd /tmp
curl -Lo git.tgz https://s3-us-west-2.amazonaws.com/res.carterjones.info/pkg/centos7/git/git-2.21.0.tar.gz
tar -xf git.tgz -C /

# Make sure it loads.
git --help
