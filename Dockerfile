FROM postgres:10.3

# credit and thanks to clkao/postgres-plv8:9.6

MAINTAINER Dan Lynch <pyramation@gmail.com>

ENV PLV8_VERSION=v2.3.0 \
    PLV8_SHASUM="5b46f1c036076e57bad18929919648fffa084cdb79a14710879eac3aa40ba091  v2.3.0.tar.gz"

RUN apt-get update \
   && apt-get upgrade -y \
   && apt-get install -y \
   build-essential \
   ca-certificates \
   pkg-config \
   curl \
   gcc \
   git \
   libpq-dev \
   postgresql-server-dev-$PG_MAJOR \
   make \
   python-pip \
   python2.7 \
   python2.7-dev \
   && apt-get autoremove \
   && apt-get clean

ENV GYP_CHROMIUM_NO_ACTION=0 \
    DEPOT_TOOLS_WIN_TOOLCHAIN=0

RUN mkdir -p /tmp/build \
  && curl -o /tmp/build/${PLV8_VERSION}.tar.gz -SL "https://github.com/plv8/plv8/archive/$PLV8_VERSION.tar.gz" \
  && cd /tmp/build \
  && echo ${PLV8_SHASUM} | sha256sum -c \
  && tar -xzf /tmp/build/${PLV8_VERSION}.tar.gz -C /tmp/build/ \
  && cd /tmp/build/plv8-${PLV8_VERSION#?} \
  && make \
  && make install \
  && strip /usr/lib/postgresql/${PG_MAJOR}/lib/plv8.so \
  && rm -rf /tmp/build /var/lib/apt/lists/*
