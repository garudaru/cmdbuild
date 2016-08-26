#!/bin/ash

docker-compose stop
docker-compose rm --all
docker rm `docker ps -a -q`
docker volume rm `docker volume ls -q`
