DOCKER_COMPOSE := docker compose
.PHONY: all up down restart stop build clean fclean bash logs show makeDirs

all: up

up: makeDirs
	sh ./tools/make_ssl.sh
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml up -d --build

down:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down

restart:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml restart

stop:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml stop

build:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml build

clean: down
	docker sysstem prune -f --all 

fclean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v --rmi all
	sudo rm -rf /home/jinam/data
logs:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml logs $(SERVICE)

bash:
	docker exec -it $(service) /bin/bash
show: 
	docker ps -a | tail -n +1
	docker images | tail -n +1
	docker network ls | tail -n +1
	docker volume ls | tail -n +1
makeDirs:
	mkdir -p /home/jinam/data/wordpress_data /home/jinam/data/mariadb_data > /dev/null 2>&1

