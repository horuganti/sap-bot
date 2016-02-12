FROM node:5.6-slim
MAINTAINER Wantedly Infrastructure Team "dev@wantedly.com"

ENV HUBOT_NAME sap
ENV HUBOT_SLACK_TOKEN false
ENV HUBOT_GOOGLE_CSE_ID false
ENV HUBOT_GOOGLE_CSE_KEY

COPY . /opt/
WORKDIR /opt

RUN npm install --production; npm cache clean
EXPOSE 8080
VOLUME /opt/scripts

CMD ["/opt/bin/hubot", "--name", "${HUBOT_NAME}", "--adapter", "slack"]
