# README

Experimentation with running docker/rails tests in a particular CI environment where postgres has to be installed and run inside the image.

The Dockerfile is kept small, a shell script is used to install, configure and run postgres.

Two versions exist:

## alpine

```
docker build --file Dockerfile.alpine .
```

```
docker run <image-id> /usr/src/app/run-tests.alpine.sh
```

## slim

```
docker build --file Dockerfile.slim .
```

```
docker run <image-id> /usr/src/app/run-tests.slim.sh
```
