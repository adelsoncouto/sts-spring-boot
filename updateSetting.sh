#!/bin/bash

# verifico se foi informado o container
if [[ -z "$1" ]];then
  echo 'Informe o nome ou id do container'
  exit 1;
fi

# verifico se o container existe
container=$(docker ps --format '{{.Names}}' | grep "$1" | wc -l)
if [[ $container -lt 1 ]];then
  echo 'Container não econtrado'
  exit 1
fi

# verifico se foi informado o usuário do container
if [[ -z "$2" ]];then
  echo 'Informe o usuário do container'
  exit 1
fi

# removo o settings local se existir
if [[ -n ./.settings ]];then
  rm -rf .settings
fi

# copio o settings do container
docker cp $1:/home/$2/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings ./

# verifico se foi copiado com sucesso
if [[ -z ./.settings ]];then
  echo 'Não encontrei o .settings no container'
  exit 1
fi

# removo o .settings atual
rm -rf ./workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings

# salvo o novo
mv .settings ./workspace/.metadata/.plugins/org.eclipse.core.runtime/

git add workspace

echo 'Atualize a versão no build.sh e faça o commit e push'





