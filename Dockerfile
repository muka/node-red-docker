FROM armv7/armhf-ubuntu:wily
MAINTAINER Luca Capra <luca.capra@gmail.com>

RUN apt-get update -qq && apt-get install curl -yqq

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get update -qq \
  && apt-get install -yqq python2.7 python2.7-dev libicu-dev make g++ git nodejs -yq \
  && apt-get autoremove -yqq && apt-get autoclean -qq \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/node-red/node-red.git node-red
WORKDIR node-red/

RUN npm i && npm i -g grunt-cli && grunt build

RUN cp ./settings.js ./settings.js.orig && sed s/1880/80/ ./settings.js > ./settings.js

# ignored for resin.io
EXPOSE 80
VOLUME [ "/data" ]

ENTRYPOINT [ "node", "./red", "--settings", "../settings.js", "/data/flow.json" ]
