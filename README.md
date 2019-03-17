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


