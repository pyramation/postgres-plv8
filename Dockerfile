FROM postgres:10.3

MAINTAINER Dan Lynch <pyramation@gmail.com>

RUN apt-get update \
   && apt-get upgrade -y \
   && apt-get install -y \
   build-essential \
   ca-certificates \
   curl \
   gcc \
   git \
   libpq-dev \
   make \
   postgresql-common \
   postgresql-server-dev-$PG_MAJOR \
   sudo

ENV GYP_CHROMIUM_NO_ACTION=0 \
    DEPOT_TOOLS_WIN_TOOLCHAIN=0

RUN mkdir -p /tmp/build \
  && cd /tmp/build \
  && git clone https://github.com/pyramation/plv8.git
  && cd plv8 \
  && make \
  && make install \
  && strip /usr/lib/postgresql/${PG_MAJOR}/lib/plv8.so \
  && rm -rf /tmp/build /var/lib/apt/lists/*

RUN apt-get autoremove \
  && apt-get clean
