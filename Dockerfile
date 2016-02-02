FROM ubuntu:wily
MAINTAINER Luca Capra <luca.capra@gmail.com>

RUN apt-get update -qq
RUN apt-get install -yqq software-properties-common python-software-properties libicu-dev make g++ curl git

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get install nodejs -yq
RUN apt-get autoremove -yqq
RUN apt-get autoclean -qq

RUN git clone https://github.com/node-red/node-red.git node-red
WORKDIR node-red/
RUN npm i

RUN sed s/1880/80/ ./settings.js > ../settings.js

RUN npm install -g grunt-cli
RUN grunt build

EXPOSE 80

ENTRYPOINT node ./red --settings ../settings.js
