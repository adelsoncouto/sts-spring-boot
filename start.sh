#!/bin/bash

# crio grupo
groupadd -r $USER_NAME -g $USER_ID 

# crio o diretório se ele não existir
if [[ ! -d '/home/'"$USER_NAME" ]];then
	mkdir -p '/home/'"$USER_NAME"
fi

# crio usuario  
useradd -u $USER_ID -r -d '/home/'"$USER_NAME" -g "$USER_NAME" -p root -s /bin/bash -c "$USER_FULL" "$USER_NAME"

# permissoes do usuario
echo "$USER_NAME"' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# imprimo a ajuda ajuda
echo 'Para usar digite um dos seguintes comandos (use o & para não travar o terminal): '
echo '  sts          - Abre o STS'
echo '  dbeaver      - Abre o dbeaver'
echo '  mvn          - Executa o maven'
echo '  mongodb      - MongoDB'

# muda para o diretorio do usuario
cd '/home/'"$USER_NAME"

# recuperando configuracoes
if [[ ! -d '/home/'"$USER_NAME"'/.eclipse' ]];then
  cp -r '/tmp/workspace' '/home/'"$USER_NAME"'/workspace'
  chown $USER_NAME:$USER_NAME '/home/'"$USER_NAME" -R
fi


mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# mudo para o usuario criado
su  $USER_NAME

