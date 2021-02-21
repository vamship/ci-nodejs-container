FROM alpine:3.11

ARG APP_NAME
ARG APP_DESCRIPTION
ARG APP_VERSION
ARG BUILD_TIMESTAMP

# Metadata
LABEL org.label-schema.name=$APP_NAME \
      org.label-schema.description=$APP_DESCRIPTION \
      org.label-schema.version=$APP_VERSION \
      org.label-schema.build-date=$BUILD_TIMESTAMP \
      org.label-schema.vcs-url="https://github.com/vamship/ci-nodejs-container" \
      org.label-schema.url="https://hub.docker.com/repository/docker/vamship/ci-nodejs"

ENTRYPOINT ["/bin/sh"]
