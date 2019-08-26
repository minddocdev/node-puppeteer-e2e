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
ENV NODE_ENV="production"
ENV LANG="C.UTF-8"

# Installs latest Chromium (76) package.
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  freetype-dev \
  harfbuzz \
  ca-certificates \
  ttf-freefont \
  nodejs \
  yarn

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v1.17.0 works with Chromium 76.
RUN yarn add puppeteer@1.17.0

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
  && mkdir -p /home/pptruser/Downloads /app \
  && chown -R pptruser:pptruser /home/pptruser \
  && chown -R pptruser:pptruser /app

# Run everything after as non-privileged user.
USER pptruser
