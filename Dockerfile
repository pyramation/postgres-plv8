FROM postgres:10.3

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
   g++ \
   git \
   libc++-dev \
   libpq-dev \
   postgresql-server-dev-$PG_MAJOR \
   make \
   python-pip \
   python2.7 \
   python2.7-dev

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

RUN apt-get autoremove \
  && apt-get clean

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN echo LANG=en_US.UTF-8 > /etc/locale.conf && locale-gen

RUN mkdir -p /home/postgres
RUN echo export PATH=\$PATH:/usr/lib/postgresql/$PG_MAJOR/bin > /home/postgres/.profile
RUN echo export PGDATA=$PGDATA >> /home/postgres/.profile
RUN echo echo Hello postgres! >> /home/postgres/.profile
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
