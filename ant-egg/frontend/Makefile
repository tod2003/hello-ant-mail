NAME_IMAGE = docker_nginx_building
NAME_CONTAINER = docker_nginx_building
PORT = 8088
PORT_NGINX = 80

build:
	docker build -f Dockerfile.hub -t $(NAME_IMAGE) .

deploy:
	docker run -d -it -p=$(PORT):$(PORT_NGINX) --name="$(NAME_CONTAINER)" $(NAME_IMAGE)

remove:
	docker stop $(NAME_CONTAINER)
	docker rm $(NAME_CONTAINER)
	docker rmi $(NAME_IMAGE)
