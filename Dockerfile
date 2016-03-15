FROM node:0.12
MAINTAINER Wantedly Infrastructure Team "dev@wantedly.com"

ENV HUBOT_NAME bot
ENV HUBOT_SLACK_TOKEN false
ENV HUBOT_GOOGLE_CSE_ID false
ENV HUBOT_GOOGLE_CSE_KEY false
ENV HUBOT_GITHUB_EVENT_NOTIFIER_TYPES pull_request:synchronized,push
ENV TZ Asia/Tokyo

# Install base packages
RUN npm install -g hubot coffee-script redis

COPY . /opt/
WORKDIR /opt

RUN npm install --production && npm cache clean

EXPOSE 8080

CMD ["/opt/bin/hubot", "--name", "${HUBOT_NAME}", "--adapter", "slack"]
