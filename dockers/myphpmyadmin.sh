#docker pull phpmyadmin
docker run -d \
    --name myadmin \
    -e PMA_HOST=$(ip route show | grep docker0 | awk '{print $9}') \
    -e PMA_PORT=3306 \
    -p 8080:80 \
    phpmyadmin/phpmyadmin
