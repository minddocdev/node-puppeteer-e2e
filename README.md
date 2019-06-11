# `node-puppeteer-e2e`

> Docker Image with Node.js, and Puppeteer for automated e2e testing

This Docker image is created to easily execute automated end-to-end tests with Puppeteer in a container or in your CI pipeline.

It has Node.js, NPM, Yarn, and Puppeteer installed:

```
$ docker run -it minddocdev/node-puppeteer-e2e
minddocdev@a43b9787b9c2:/app$ npm --version
6.9.0
minddocdev@a43b9787b9c2:/app$ node --version
v10.16.0
```

[![Build Status on the master branch](https://travis-ci.org/minddocdev/node-puppeteer-e2e.svg?branch=master)](https://travis-ci.org/minddocdev/node-puppeteer-e2e)

## Docker Hub

### `docker pull`

You can pull the image from Docker Hub using the `docker pull minddocdev/node-puppeteer-e2e` command. We are using [automated build set up](https://docs.docker.com/docker-hub/builds/#create-an-automated-build).

```
docker pull minddocdev/node-puppeteer-e2e
```

### `docker run`

To jump into the container's `bash` shell, run `docker run -it minddocdev/node-puppeteer-e2e`.

If you want to load a volume, you can execute:

```
$ docker run --rm --workdir /app --volume "$PWD:/app" --interactive --tty minddocdev/node-puppeteer-e2e /bin/bash
## Or using shorthand flags
$ docker run -w /app -v "$PWD:/app" -it minddocdev/node-puppeteer-e2e /bin/bash
## Install dependencies and run tests with npm
root@c0ff3e:/app# npm i && npm t
```

It's also likely that you don't want to jump into `bash`, because you understand already how things work and you just want to execute your e2e test suite.

To run the tests using one npm script (for example, if you have `npm install` in your `pretest` script), run:

```
docker run --rm -w /app -v "$PWD:/app" -t minddocdev/node-puppeteer-e2e npm test
```

If your end-to-end test suite requires multiple commands being executed, you should use:

```
docker run --rm -v "$PWD:/app" -t node-puppeteer-e2e /bin/bash -c "npm install && npm test && echo 'Yuppiee'"
```

### `docker build`

You can also build the image yourself. Checkout the repository

```
$ git clone https://github.com/mind-doc/node-puppeteer-e2e.git
$ cd node-puppeteer-e2e
$ docker build -t minddocdev/node-puppeteer-e2e:latest .
$ docker images minddocdev/node-puppeteer-e2e
```

# Links

- [Docker Hub `minddocdev/node-puppeteer-e2e`](https://hub.docker.com/r/minddocdev/node-puppeteer-e2e/)
- [GitHub `mind-doc/node-puppeteer-e2e`](https://github.com/minddocdev/node-puppeteer-e2e)
- [Travis CI](https://travis-ci.org/minddocdev/node-puppeteer-e2e)
