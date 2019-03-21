all:
	/bin/bash ./build.sh

build:
	/bin/bash ./build.sh

upload:
	aws s3 cp scratch/ s3://res.carterjones.info/pkg/rpm/zsh

test:
	mkdir -p scratch
	cp test.sh scratch/test.sh
	docker run -v $(PWD)/scratch:/tmp centos:7 /bin/bash /tmp/test.sh
