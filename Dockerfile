FROM node:latest
MAINTAINER Wantedly Infrastructure Team "dev@wantedly.com"

ENV HUBOT_NAME bot
ENV HUBOT_SLACK_TOKEN false
ENV HUBOT_GOOGLE_CSE_ID false
ENV HUBOT_GOOGLE_CSE_KEY false
ENV HUBOT_GITHUB_EVENT_NOTIFIER_TYPES pull_request:synchronized,push
ENV TZ Asia/Tokyo

# Install requirements and clean up after ourselves
RUN apt-get -q update \
  && apt-get -qy install apt-transport-https ca-certificates git-core \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Docker
RUN wget -qO- https://get.docker.com/ | sh

# Install hubot and related
RUN npm install -g hubot yo generator-hubot coffee-script

# Setup a user to run as
RUN adduser --disabled-password --gecos "" yeoman
USER yeoman
WORKDIR /home/yeoman

# Clone the slack adapter because current released one has a bug in
# sending messages direct to people hubot hasn't spoken to before
RUN git clone https://github.com/slackhq/hubot-slack/

# Create hubot
RUN yo hubot --name bot --description "sap-bot" --adapter slack --defaults

# Custom Script
ADD scripts/sap.coffee /home/yeoman/scripts/sap.coffee
ADD external-scripts.json /home/yeoman/external-scripts.json
ADD package.json /home/yeoman/package.json

# Use docker
USER root

EXPOSE 8080

CMD ["/home/yeoman/bin/hubot", "--name", "${HUBOT_NAME}", "--adapter", "slack"]
