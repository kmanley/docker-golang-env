NAME = kmanley/docker-golang-env
VERSION=1.0

all: build

build:
	docker build -t $(NAME):$(VERSION) -rm=true .

run:
	docker run -d -p 127.0.0.1:2222:22 kmanley/docker-golang-env:1.0
	sleep 1
	ssh docker-golang-env sakura &




