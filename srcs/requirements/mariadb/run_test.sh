#!/bin/bash
set -e

# Define environment variables
DOCKER_IMAGE_NAME=my-mariadb-image
CONTAINER_NAME=my-mariadb-container

# Build the Docker image
docker build -t $DOCKER_IMAGE_NAME .

# Run the Docker container
docker run -d --name $CONTAINER_NAME -p 3306:3306 $DOCKER_IMAGE_NAME

# Wait for the MariaDB container to start
until docker exec $CONTAINER_NAME mysqladmin ping -hlocalhost -uroot > /dev/null 2>&1; do
    echo "Waiting for MariaDB container to start..."
    sleep 1
done

# Check if the database exists
docker exec $CONTAINER_NAME mysql -uroot -e "SHOW DATABASES LIKE 'mydb'" | grep 'mydb'

# Check if the user exists
docker exec $CONTAINER_NAME mysql -uroot -e "SELECT user FROM mysql.user WHERE user='myuser'" | grep 'myuser'

# Check if the user has privileges on the database
docker exec $CONTAINER_NAME mysql -uroot -e "SELECT * FROM mysql.db WHERE user='myuser' AND db='mydb'" | grep 'myuser'

# Stop and remove the MariaDB container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Remove the Docker image
docker rmi $DOCKER_IMAGE_NAME

echo "MariaDB Docker image and container test completed successfully."
