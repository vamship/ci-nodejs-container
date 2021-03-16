FROM debian:10.8-slim

ARG APP_NAME
ARG APP_DESCRIPTION
ARG APP_VERSION
ARG BUILD_TIMESTAMP

# Metadata
LABEL org.label-schema.name=$APP_NAME \
      org.label-schema.description=$APP_DESCRIPTION \
      org.label-schema.version=$APP_VERSION \
      org.label-schema.build-date=$BUILD_TIMESTAMP \
      org.label-schema.vcs-url="https://github.com/vamship/upgrade-runner-node-container" \
      org.label-schema.url="https://hub.docker.com/repository/docker/vamship/upgrade-runner-node"

WORKDIR /

ENV NVM_DIR=/usr/local/nvm
ENV BASH_ENV=/usr/local/nvm/nvm.sh

RUN mkdir -p ${NVM_DIR} \
    && echo '\. "${NVM_DIR}/nvm.sh"' >> /etc/bash.bashrc \
    && apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh \
        | bash \
    && \. "$NVM_DIR/nvm.sh" \
    && nvm install lts/erbium \
    && nvm use lts/erbium \
    && npm install -g npm \
    && npm install -g npm-check-updates \
    && nvm install lts/fermium \
    && nvm use lts/fermium \
    && npm install -g npm \
    && npm install -g npm-check-updates \
    && nvm alias default lts/fermium

COPY ./_scripts/_nvmrc /.nvmrc

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
