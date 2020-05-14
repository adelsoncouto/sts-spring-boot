FROM ubuntu:18.04
MAINTAINER Adelson Silva Couto <adscouto@gmail.com>

USER root

# Dependências
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && DEBIAN_FRONTEND=noninteractive \
  && sed 's/main$/main universe/' -i /etc/apt/sources.list \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  curl \
  sudo \
  locales \
  libgtk-3-0 \
  libxext-dev \
  libxrender-dev \
  libxtst-dev \
  jq \
  iproute2 \
  vim \
  libnss3-dev \
  iputils-ping \
  libgtk2.0-dev \
  libnotify-dev \
  chromium-chromedriver \
  chromium-browser \
  libcurl4 \
  openssl \
  openvpn \
  subversion \
  nginx \
  git \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen pt_BR.UTF-8

# variáveis gerais
ENV TZ="America/Sao_Paulo" \
  LANG="pt_BR.UTF-8" \
  LANGUAGE="pt_BR:pt:en" \
  LC_CTYPE="pt_BR.UTF-8" \
  LC_NUMERIC="pt_BR.UTF-8" \
  LC_TIME="pt_BR.UTF-8" \
  LC_COLLATE="pt_BR.UTF-8" \
  LC_MONETARY="pt_BR.UTF-8" \
  LC_MESSAGES="pt_BR.UTF-8" \
  LC_PAPER="pt_BR.UTF-8" \
  LC_NAME="pt_BR.UTF-8" \
  LC_ADDRESS="pt_BR.UTF-8" \
  LC_TELEPHONE="pt_BR.UTF-8" \
  LC_MEASUREMENT="pt_BR.UTF-8" \
  LC_IDENTIFICATION="pt_BR.UTF-8" \
  JAVA_HOME="/usr/src/jvm/java" 

# openjdk 8
RUN mkdir -p /usr/src/jvm/java8 \
  && cd /usr/src/jvm/java8 \
  && curl -fSL 'https://download.java.net/openjdk/jdk8u40/ri/openjdk-8u40-b25-linux-x64-10_feb_2015.tar.gz' -o java.tar.gz \
  && tar -zxf java.tar.gz \
  && rm -rf java.tar.gz \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/jvm/java8/bin -R \
  && ln -s /usr/src/jvm/java8 /usr/src/jvm/java 

# maven
RUN mkdir /usr/src/mvn \
  && cd /usr/src/mvn \
  && curl -fSL https://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -o apache.tar.gz \
  && tar -zxf apache.tar.gz \
  && rm -rf apache.tar.gz \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/mvn/bin -R

# mongodb
RUN mkdir -p /usr/src/mongodb \
  && mkdir -p /data/db \
  && mkdir -p /var/log/mongodb \
  && cd /usr/src/mongodb \
  && curl -fSL 'http://downloads.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1804-4.0.5.tgz' -o mongodb.tgz \
  && tar -zxf mongodb.tgz \
  && rm -rf mongodb.tgz \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/mongodb/bin -R 

# sts
RUN mkdir -p /usr/src/sts \
  && cd /usr/src/sts \
  && curl -fSL 'https://download.springsource.com/release/STS4/4.6.1.RELEASE/dist/e4.15/spring-tool-suite-4-4.6.1.RELEASE-e4.15.0-linux.gtk.x86_64.tar.gz' -o sts.tar.gz \
  && tar -zxf sts.tar.gz \
  && rm -rf sts.tar.gz \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/sts/SpringToolSuite4

# openjdk 14
RUN mkdir -p /usr/src/jvm/java14 \
  && cd /usr/src/jvm/java14 \
  && curl -fSL 'https://download.java.net/java/GA/jdk14.0.1/664493ef4a6946b186ff29eb326336a2/7/GPL/openjdk-14.0.1_linux-x64_bin.tar.gz' -o java.tar.gz \
  && tar -zxf java.tar.gz \
  && rm -rf java.tar.gz \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/jvm/java14/bin -R 

# dbeaver
RUN mkdir /usr/src/dbeaver \
  && cd /usr/src/dbeaver \
  && curl -fSL 'https://dbeaver.io/files/7.0.4/dbeaver-ce-7.0.4-linux.gtk.x86_64.tar.gz' -o dbeaver.tar.gz \
  && tar -zxf dbeaver.tar.gz \
  && rm -rf dbeaver.tar.gz \
  && mv dbeaver dbeaver-dir \
  && for n in $(ls);do mv ./$n/* ./;rm -rf ./$n;done \
  && chmod +x /usr/src/dbeaver/dbeaver

# instalo o nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
  && apt-get update \
  && apt-get install -y --no-install-recommends nodejs

# instalo outros complementos
RUN npm install -g npm \
  && npm install -g cordova \
  && npm install -g typescript \
  && npm install -g @angular/cli \
  && npm install -g ionic \
  && npm install -g gulp-cli

# instalo yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install yarn \
  && apt-get install --no-install-recommends yarn

# instala chrome
RUN curl -L https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get -y install google-chrome-stable dbus-x11 packagekit-gtk3-module libcanberra-gtk-module firefox -y \
  && mkdir /var/run/dbus/

# remove temporário
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && mkdir -p /usr/src/init \
  && ln -s /usr/src/sts/SpringToolSuite4 /usr/local/sbin/sts \
  && ln -s /usr/src/dbeaver/dbeaver /usr/local/sbin/dbeaver \
  && ln -s /usr/src/jvm/java/bin/* /usr/local/sbin/ \
  && ln -s /usr/src/mvn/bin/* /usr/local/sbin/ \
  && ln -s /usr/src/mongodb/bin/* /usr/local/sbin/

# script inicial
COPY ./workspace /tmp/workspace
COPY ./start.sh /usr/src/init/start.sh
RUN chmod +x /usr/src/init/start.sh
RUN mkdir -p /dev/net \
  && mknod /dev/net/tun c 10 200 \
  && chmod 600 /dev/net/tun

# inicia o bash
CMD sudo dbus-daemon --system --fork && /usr/src/init/start.sh
