ubuntu:
	docker run -it --name=myubuntu -v  /Users/tod/work:/work ubuntu /bin/bash

ubuntu-login:
	docker start myubuntu
	docker attach myubuntu
	docker exec -it myubuntu /bin/bash

ubuntu-remove:
	docker stop myubuntu
	docker rm myubuntu

nodejs:
	docker run -it --name=muynodejs -v /Users/tod/work:/work nodejs /bin/bash

centos:
	docker run --security-opt seccomp=unconfined -it --name=mycentos -v  /Users/tod/work:/work centos /bin/bash

centos-login:
	docker start mycentos
	docker attach mycentos
	docker exec -it mycentos /bin/bash

centos-remove:
	docker stop mycentos
	docker rm mycentos



phpmyadmin:
	docker run -d \
    	--name myadmin \
    	-e PMA_HOST=127.0.0.1 \
    	-e PMA_PORT=3306 \
	-e PMA_USER=root \
	-e PMA_PASSWORD=root \
	-e PMA_ROOT_PASSWORD=root \
	-e PMA_DATABASE=mysql \
    	-p 8089:80 \
    	phpmyadmin/phpmyadmin

phpmyadmin-remove:
	docker stop myadmin
	docker rm myadmin

mariadb:
	docker search mariadb
	docker pull mariadb
	#mkdir ~/mysql
	docker run -v ~/mysql/:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root  --privileged=true --restart unless-stopped   --name mymariadb -d mariadb:latest

mariadb-remove:
	docker stop mymariadb
	docker rm mymariadb

dblog:
	docker ps -a
	docker logs mymariadb

dbtest:
	mysql -h 127.0.0.1  -uroot -P3306 -proot
	#show databases;
