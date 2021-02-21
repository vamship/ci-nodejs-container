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

COPY ./_scripts/_bashrc /root/.bashrc
COPY ./_scripts/_nvmrc /root/.nvmrc

RUN apt-get update \
    && apt-get install -y curl \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh \
        | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install lts/erbium \
    && nvm install lts/fermium \
    && nvm alias default lts/fermium \
    && nvm use lts/erbium \
    && npm install -g npm-check-updates \
    && nvm use lts/fermium \
    && npm install -g npm-check-updates

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
