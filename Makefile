DOCKER_COMPOSE := docker compose

.PHONY: all up down restart stop build clean fclean bash logs show makeDirs

all: up

up: makeDirs
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up -d

down:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down

restart:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml restart

stop:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml stop

build:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build

clean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml clean

fclean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v --rmi all
	sudo rm -rf /home/jinam/data

bash:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml exec -it $(SERVICE)

logs:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml logs $(SERVICE)

show: 
	docker ps -a | tail -n +1
	docker images | tail -n +1
	docker network ls | tail -n +1
	docker volume ls | tail -n +1
makeDirs:
	mkdir -p /home/jinam/data/wordpress_data /home/jinam/data/mariadb_data > /dev/null 2>&1

