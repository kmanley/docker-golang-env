NAME = kmanley/golang-env
VERSION=1.0

all: build

build:
	docker build -t $(NAME):$(VERSION) -rm - < Dockerfile 

run:
	docker run -i -t -p 6060:6060 -p 9000:9000 kmanley/golang-env:$(VERSION)



