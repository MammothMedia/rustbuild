# build from standard rust alpine
FROM rust:1.42-alpine3.11 as build

RUN apk update &&\
  apk add binutils build-base musl g++
# add mysql dependencies
RUN apk add mariadb-embedded mariadb-embedded-dev mariadb-static mariadb-dev

# add docker
RUN apk add docker

RUN apk add py-pip
RUN pip install awscli

RUN RUSTFLAGS="-C target-feature=-crt-static" cargo install sccache

ENV RUSTC_WRAPPER=sccache
ENV SCCACHE_CACHE_SIZE=1G

WORKDIR /app

CMD ["cargo", "test"]