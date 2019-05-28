#!/bin/bash

imagem='adelsoncouto/sts-spring-boot'
versao='1.0.26'

ok=$(docker images --format "{{.Repository}}:{{.Tag}}"| grep $imagem:$versao | wc -l)

if [[ $ok -lt 1 ]]; then
  docker build -t $imagem:$versao .
fi

cd ~

container_name='sts'
container_ip='100'


if [[ -n "$1" ]]; then
	if [[ "$1" = "--help" ]];then
		echo './build [container] [ultimo_octeto_IPv4]'
		exit 0
	fi
	container_name="$1"
fi

if [[ -n "$2" ]]; then
	container_ip="$2"
fi

#  --memory=4G \
docker run -it --rm \
  --hostname $container_name \
  --name $container_name \
  --net br_172_20_10 \
  --ip 172.20.10.$container_ip \
  -v /home/adelson/trabalho:/media/trabalho \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY \
  -e USER_ID=1000 \
  -e USER_NAME=adelson \
  -e USER_FULL='Adelson Silva Couto' \
  $imagem:$versao
