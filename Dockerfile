FROM postgres:10

MAINTAINER Dan Lynch <pyramation@gmail.com>

ENV PLV8_VERSION=v2.3.0 \
    PLV8_SHASUM="5b46f1c036076e57bad18929919648fffa084cdb79a14710879eac3aa40ba091  v2.3.0.tar.gz"

RUN buildDependencies="build-essential \
    ca-certificates \
    curl \
    git-core \
    postgresql-server-dev-$PG_MAJOR" \
  && apt-get update \
  && apt-get install -y --no-install-recommends ${buildDependencies} \
  && mkdir -p /tmp/build \
  && curl -o /tmp/build/${PLV8_VERSION}.tar.gz -SL "https://github.com/plv8/plv8/archive/$PLV8_VERSION.tar.gz" \
  && cd /tmp/build \
  && echo ${PLV8_SHASUM} | sha256sum -c \
  && tar -xzf /tmp/build/${PLV8_VERSION}.tar.gz -C /tmp/build/ \
  && cd /tmp/build/plv8-${PLV8_VERSION#?} \
  && make static \
  && make install \
  && strip /usr/lib/postgresql/${PG_MAJOR}/lib/plv8.so \
  && cd / \
  && apt-get clean \
  && apt-get remove -y  ${buildDependencies} \
  && apt-get autoremove -y \
  && rm -rf /tmp/build /var/lib/apt/lists/*
