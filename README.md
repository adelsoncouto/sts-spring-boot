# STS - SPRING BOOT

Container de desenvolvimento spring boot

# USO

```bash
docker run -it --rm \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /home/$USER:/media/trabalho \
  --hostname sts\
  --name sts \
  -e USER_ID=`id -u` \
  -e USER_NAME=$USER \
  -e USER_FULL=$USERNAME \
  -e DISPLAY \
  --memory=4G \
  adelsoncouto/sts-spring-boot:tagname
```

# Templates

**sbAutowiredRepository** autowired para repository


**sbAutowiredService** autowired para service

**sbBase64** atributo para conteudo base64

**sbBR** class para tratar datas e horas

**sbDomain** class entity

**sbEnum** enum padronizada

**sbEnumElementCollection** atributo do tipo enum para entity 

**sbEnumKey** atributo da enum padronizada

**sbEnumService** service para enum

**sbGetAdd** get e set a add para List com o retorno do this no set, util para o Method chaining

**sbGetSet** get e set com o retorno do this no set, util para o Method chaining

**sbGetSetToZonedDateTime** get e set com parse de String para ZonedDateTime e vice-versa

**sbHelper** class helper 

**sbPostResource** requestMap post para controller

**sbRepository** base de repository

**sbRepositoryFindAll** metódo de find para repository

**sbResource** base para controller

**sbService** base para service

**sbTempo** atributo de tempo com ZonedDateTime
