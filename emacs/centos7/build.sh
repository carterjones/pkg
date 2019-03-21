#!/bin/bash
set -euxo pipefail

# Install AWS CLI.
sudo apt-get install -y python3
sudo python3 get-pip.py
sudo pip3 install --upgrade pip
sudo pip3 install awscli

# Run the build.
sudo /bin/bash -c "echo 0 > /proc/sys/kernel/randomize_va_space"
export VERSION="26.1.92"
docker build -f Dockerfile -t carterjones/emacs:latest --build-arg VERSION="${VERSION}" .
sudo /bin/bash -c "echo 2 > /proc/sys/kernel/randomize_va_space"

# Perform the installation to a local Docker container so we can extract the
# files that are installed and store them in a tar file.
mkdir -p scratch
cp archive-files.sh scratch/
chmod +x scratch/archive-files.sh
docker run -d -v $(pwd)/scratch:/tmp/scratch carterjones/emacs:latest /bin/bash -c "cd /build/emacs/emacs && make install && touch /tmp/done-with-build && sleep infinity"
container=$(docker ps -q)

# Wait for the build to finish.
for i in `seq 1 10`; do
    if [[ "${i}" == "10" ]]; then
        echo "Something likely went wrong with the build."
        exit 1
    fi
    if docker exec "${container}" /bin/bash -c "ls /tmp/done-with-build"; then
        # If the canary file is found, then delete it and continue.
        docker exec "${container}" /bin/bash -c "rm /tmp/done-with-build"
        break
    else
        sleep 5
    fi
done

# Get a list of files to archive.
docker diff "${container}" | sed "s,^..,,g" | grep -v "^\/tmp" > scratch/file-list.txt

# Create a tar file inside the container at the mount point.
docker exec "${container}" /bin/bash -c "/tmp/scratch/archive-files.sh"
mv ./scratch/emacs-files.tar.gz "./scratch/emacs-${VERSION}.tar.gz"

# Upload to S3.
aws s3api put-object \
    --acl public-read \
    --bucket res.carterjones.info \
    --key "pkg/centos7/emacs/emacs-${VERSION}.tar.gz" \
    --body "./scratch/emacs-${VERSION}.tar.gz"
