# build and run Docker containers

.PHONY: all start build stop check clean re setup dir

DOCKER:=-f ./srcs/docker-compose.yml
ENV:=--env-file ./srcs/.env
WP_VOL:=~/data/website
DB_VOL:=~/data/database
IGN:= ||:

all: dir
	docker-compose $(DOCKER) $(ENV) up -d --build

start:
	docker-compose $(DOCKER) $(ENV) up

build:
	docker-compose $(DOCKER) $(ENV) build

stop:
	docker compose $(DOCKER) down

check:
	docker compose $(DOCKER) ps

clean: stop
	docker stop $$(docker ps -qa) $(IGN)
	docker rm $$(docker ps -qa) $(IGN)
	docker rmi -f $$(docker images -qa) $(IGN)
	docker volume rm $$(docker volume ls -q) $(IGN)
	docker network rm $$(docker network ls -q) 2>/dev/null $(IGN)

fclean: clean
	docker system prune -f -a --volumes $(IGN)
	sudo rm -rf ~/data/

dir:
	@if test ! -d $(DB_VOL) || test ! -d "$(WP_VOL)"; then \
		mkdir -p $(DB_VOL) $(WP_VOL); \
	fi

setup: dir
	sudo sh -c 'echo "127.0.0.1 pdolinar.42.fr" >> /etc/hosts'

re: clean all

