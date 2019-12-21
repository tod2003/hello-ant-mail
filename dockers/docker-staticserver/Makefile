IMAGE_NAME = docker_nginx_file
CONTAINER_NAME = myfileserver
PORT = 12901
PORT_NGINX = 8080

build:
	docker build -t $(IMAGE_NAME) .

deploy:
	docker run -d -it -v /Users/tod:/var/data -p=$(PORT):$(PORT_NGINX) --privileged=true  --name="$(CONTAINER_NAME)" $(IMAGE_NAME)

login:
	docker exec -it $(CONTAINER_NAME) /bin/sh

save:
	docker save -o $(IMAGE_NAME).tar $(IMAGE_NAME)

load:
	docker load -i $(IMAGE_NAME).tar


stop:
	docker stop $(CONTAINER_NAME)

restart:
	docker restart $(CONTAINER_NAME)

remove:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)
	docker rmi $(IMAGE_NAME)
