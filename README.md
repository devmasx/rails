# rails

## Image with
```Dockerfile
FROM ruby:2.5.1-alpine

RUN apk --update add gcc make g++ zlib-dev
RUN gem install rails
WORKDIR /usr/src

ENTRYPOINT ["rails"]
#  docker run --user $(id -u) -it -v $(pwd):/usr/src devmasx/rails
```
