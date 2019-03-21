#!/bin/bash
set -euxo pipefail

# Create a list of files that are actual files, rather than things that docker
# claims are files, but are actually directories.
while IFS="" read -r line || [ -n "$line" ]
do
    if [[ -f "${line}" ]]; then
        echo "${line}" >> /tmp/scratch/filtered-file-list.txt
    fi
done < /tmp/scratch/file-list.txt

# Create an archive of the real files.
tar -zcvf /tmp/scratch/emacs-files.tar.gz -T /tmp/scratch/filtered-file-list.txt
