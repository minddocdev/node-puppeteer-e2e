# ---------------------------------------------------------- #
#                         Dockerfile                         #
# ---------------------------------------------------------- #
# image:    node-puppeteer-e2e                               #
# name:     minddocdev/node-puppeteer-e2e                    #
# repo:     https://github.com/mind-doc/node-puppeteer-e2e   #
# authors:  development@minddoc.com                          #
# ---------------------------------------------------------- #

FROM node:10-slim
LABEL maintainer="development@minddoc.com"

# Install dependencies required to run headless chrome / puppeteer
RUN apt-get update && \
  apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
  libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
  libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
  wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
  dpkg -i dumb-init_*.deb && rm -f dumb-init_*.deb && \
  apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && \
  yarn global add puppeteer@1.17.0 && yarn cache clean

ENV NODE_PATH="/usr/local/share/.config/yarn/global/node_modules:${NODE_PATH}"

RUN groupadd -r minddocdev && useradd -r -g minddocdev -G audio,video minddocdev

ENV LANG="C.UTF-8"

WORKDIR /app

# Run everything after as non-privileged user
RUN mkdir -p /home/minddocdev \
  && chown -R minddocdev:minddocdev /home/minddocdev \
  && chown -R minddocdev:minddocdev /usr/local/share/.config/yarn/global/node_modules \
  && chown -R minddocdev:minddocdev /app

# Switch to non-privileged user
USER minddocdev

ENTRYPOINT ["dumb-init", "--"]

# CMD ["node", "index.js"]
CMD ["/bin/bash"]
