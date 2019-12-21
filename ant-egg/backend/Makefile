NAME_IMAGE = docker_egg_building
NAME_CONTAINER = docker_egg_building
PORT = 7001
PORT_NGINX = 7001

build:
	docker build -f Dockerfile -t $(NAME_IMAGE) .

deploy:
	docker run -d -it -p=$(PORT):$(PORT_NGINX) --name="$(NAME_CONTAINER)" $(NAME_IMAGE)

remove:
	docker stop $(NAME_CONTAINER)
	docker rm $(NAME_CONTAINER)
	docker rmi $(NAME_IMAGE)

start:
	docker start $(NAME_CONTAINER)

stop:
	docker stop $(NAME_CONTAINER)


