DK_FILE = srcs/docker-compose.yml

all: build up

build:
	mkdir -p $(HOME)/data/wordpress
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/portainer
	mkdir -p $(HOME)/data/redis
	docker compose -f $(DK_FILE) build

up:
	docker compose -f $(DK_FILE) up -d

restart:
	docker compose -f $(DK_FILE) restart

down:
	docker compose -f $(DK_FILE) down

clean:
	docker compose -f $(DK_FILE) down -v

fclean:
	docker compose -f $(DK_FILE) down -v --rmi all
	docker image prune -f

re: fclean all
