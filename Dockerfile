# ---------------------------------------------------------- #
#                         Dockerfile                         #
# ---------------------------------------------------------- #
# image:    node-puppeteer-e2e                               #
# name:     minddocdev/node-puppeteer-e2e                    #
# repo:     https://github.com/minddocdev/node-puppeteer-e2e #
# authors:  development@minddoc.com                          #
# ---------------------------------------------------------- #

FROM minddocdev/node-alpine:latest

USER root

ENV CHROME_BIN="/usr/bin/chromium-browser"
ENV CHROME_PATH="/usr/lib/chromium/"
ENV NODE_ENV="production"
ENV LANG="C.UTF-8"

# Installs latest Chromium package.
RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
  && apk add --no-cache \
  chromium@edge \
  harfbuzz@edge \
  nss@edge \
  freetype@edge \
  ttf-freefont@edge \
  ca-certificates \
  nodejs \
  yarn \
  && rm -rf /var/cache/* \
  && mkdir /var/cache/apk

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
  && adduser -D chrome \
  && chown -R chrome:chrome /usr/src/app
# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

# Autorun chrome headless with no GPU
ENTRYPOINT ["chromium-browser", "--headless", "--disable-gpu", "--disable-software-rasterizer", "--disable-dev-shm-usage"]
