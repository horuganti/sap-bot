FROM node:5.6-slim
MAINTAINER Wantedly Infrastructure Team "dev@wantedly.com"

ENV HUBOT_NAME sap
ENV HUBOT_SLACK_TOKEN false

COPY . /opt/
WORKDIR /opt

RUN npm install --production; npm cache clean
EXPOSE 8080
VOLUME /opt/scripts

CMD ["/opt/bin/hubot", "--name", "${HUBOT_NAME}", "--adapter", "slack"]
