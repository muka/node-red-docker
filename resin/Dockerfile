FROM resin/raspberrypi2-node

MAINTAINER Luca Capra <luca.capra@gmail.com>

RUN apt-get update -qq \
  && apt-get install -yqq python2.7 python2.7-dev libicu-dev make g++ curl unzip -yq \
  && apt-get autoremove -yqq && apt-get autoclean -qq \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl https://codeload.github.com/node-red/node-red/zip/master > node-red.zip && unzip node-red.zip -d ./ && mv node-red-master node-red

WORKDIR node-red/

RUN npm i && npm i -g grunt-cli && grunt build

RUN cp ./settings.js ./settings.js.orig && sed s/1880/80/ ./settings.js > ./settings.js

CMD [ "node", "./red", "--settings", "./settings.js", "/data/flow.json" ]
