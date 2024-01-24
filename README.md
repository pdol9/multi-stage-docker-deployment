# Deploying wordpress using multi-stage docker build

This project enables deployment of wordpress with other services (mariadb and nginx) as separate containers in a multi-stage docker build, using docker-compose.

This type of approach makes possible to create more efficient and smaller Docker images. It allows each stage to have its own set of instructions and dependencies, making it extremely light.

Container with nginx is set up as the only gateway on port 443 to serve online requests. It communicates with wordpress container on port 9000.
Container with wordpress also communicates with the third container mariadb on port 3306.


## Installation

To setup the project, first run:

```bash
make setup				# this will create directories for the necessary volumes
						# and add domain to the localhost
```

following by:

```bash
make 					# build and start docker containers
```

## Usage

```bash
make build				# build docker images
make start				# start docker containers
make stop				# stop docker containers
make check				# inspect docker containers
make clean				# stop & remove docker containers
make fclean				# remove not only containers, but volumes as well
```

Wordpress should be available on https://pdolinar.42.fr
