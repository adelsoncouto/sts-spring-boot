#!/bin/bash

# crio grupo
groupadd -r $USER_NAME -g $USER_ID 

# crio usuario
useradd -u $USER_ID -r -m -d /home/$USER_NAME -g $USER_NAME -p root -s /bin/bash -c "$USER_FULL" $USER_NAME

# permissoes do usuario
echo "$USER_NAME"' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# imprimo a ajuda ajuda
echo 'Para usar digite um dos seguintes comandos (use o & para não travar o terminal): '
echo '  sts          - Abre o STS'
echo '  dbeaver      - Abre o dbeaver'
echo '  mvn          - Executa o maven'

# configuro o path
echo 'PATH="/usr/src/jvm/java/bin:/usr/src/mvn/bin:'"$PATH"'"' > /etc/environment
export JAVA_HOME='/usr/src/jvm/java'

# muda para o diretorio do usuario
mkdir -p '/home/'"$USER_NAME"
cd '/home/'"$USER_NAME"

# recuperando configuracoes
if [[ ! -d '/home/'"$USER_NAME"'/.eclipse' ]];then
  cp -r '/tmp/workspace' '/home/'"$USER_NAME"'/workspace'
  chown $USER_NAME:$USER_NAME '/home/'"$USER_NAME" -R
fi

# mudo para o usuario criado
su $USER_NAME

