# Based on https://github.com/tamedia-adtec/sre-wiki/blob/master/doc/k8s/docker/golang/Dockerfile
FROM node:16-alpine

# Install dumb-init and other tools you need
RUN apk update && apk add --no-cache dumb-init

RUN mkdir -p /home/<APP_NAME>
WORKDIR /home/<APP_NAME>

COPY package*.json ./
# Uncomment the following line if you need aws-sdk
# RUN npm install aws-sdk
RUN npm install -g typescript && npm install
COPY . .

RUN addgroup -g <GROUP_ID> <APP_NAME>
RUN adduser -D -H -u <GROUP_ID> -G <APP_NAME> <APP_NAME>

RUN chown -R <APP_NAME>:<APP_NAME> /home/<APP_NAME>

USER <APP_NAME>

ENTRYPOINT ["/usr/bin/dumb-init", "--", "npm", "start"]
# CMD ["", ""]

# More info: https://github.com/tamedia-adtec/sre-wiki/tree/master/doc/k8s/docker
