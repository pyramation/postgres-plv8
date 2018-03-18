FROM postgres:10.3

# credit and thanks to clkao/postgres-plv8:9.6

MAINTAINER Dan Lynch <pyramation@gmail.com>

ENV PLV8_VERSION=v2.3.0 \
    PLV8_SHASUM="5b46f1c036076e57bad18929919648fffa084cdb79a14710879eac3aa40ba091  v2.3.0.tar.gz"

#RUN apt-get update \
#   && apt-get upgrade -y \
#   && apt-get install -y \
#   build-essential \
#   ca-certificates \
#   pkg-config \
#   curl \
#   gcc \
#   git \
#   libpq-dev \
#   postgresql-server-dev-$PG_MAJOR \
#   postgresql-common \
#   libstdc++6 \
#   g++ \
#   make \
#   python-pip \
#   python2.7 \
#   python2.7-dev

ENV GYP_CHROMIUM_NO_ACTION=0 \
    DEPOT_TOOLS_WIN_TOOLCHAIN=0

ENV VERBOSE=1

# install v8 deps
#RUN apt-get install -y -reinstall \
#  g++-6-arm-linux-gnueabihf \
#  gcc-arm-linux-gnueabihf \
#  libasound2:i386 \
#  libcap2:i386 \
#  libelf-dev:i386 \
#  libfontconfig1:i386 \
#  libglib2.0-0:i386 \
#  libgpm2:i386 \
#  libgtk-3-0:i386 \
#  libgtk2.0-0:i386 \
#  libncurses5:i386 \
#  libnss3:i386 \
#  libpango1.0-0:i386 \
#  libpci3:i386 \
#  libssl-dev:i386 \
#  libssl1.1:i386 \
#  libtinfo-dev:i386 \
#  libudev1:i386 \
#  libxcomposite1:i386 \
#  libxcursor1:i386 \
#  libxdamage1:i386 \
#  libxi6:i386 \
#  libxrandr2:i386 \
#  libxss1:i386 \
#  libxtst6:i386 \
#  linux-libc-dev:i386 \
#  ant \
#  apache2-bin \
#  autoconf \
#  binutils-aarch64-linux-gnu \
#  binutils-arm-linux-gnueabihf \
#  binutils-mips64el-linux-gnuabi64 \
#  binutils-mipsel-linux-gnu \
#  bison \
#  cdbs \
#  cmake \
#  curl \
#  dbus-x11 \
#  devscripts \
#  dpkg-dev \
#  elfutils \
#  fakeroot \
#  flex \
#  fonts-ipafont \
#  g++ \
#  g++-arm-linux-gnueabihf \
#  g++-mingw-w64-i686 \
#  gawk \
#  git-core \
#  git-svn \
#  gperf \
#  intltool \
#  lib32ncurses5-dev \
#  lib32z1-dev \
#  libapache2-mod-php7.0 \
#  libappindicator-dev \
#  libappindicator1 \
#  libappindicator3-1 \
#  libappindicator3-dev \
#  libasound2 \
#  libasound2-dev \
#  libatk1.0-0 \
#  libav-tools \
#  libbluetooth-dev \
#  libbrlapi-dev \
#  libbrlapi0.6 \
#  libbz2-1.0 \
#  libbz2-dev \
#  libc6 \
#  libc6-dev-armhf-cross \
#  libcairo2 \
#  libcairo2-dev \
#  libcap-dev \
#  libcap2 \
#  libcups2 \
#  libcups2-dev \
#  libcurl4-gnutls-dev \
#  libdrm-dev \
#  libelf-dev \
#  libexpat1 \
#  libffi-dev \
#  libffi6 \
#  libfontconfig1 \
#  libfreetype6 \
#  libgbm-dev \
#  libglib2.0-0 \
#  libglib2.0-dev \
#  libglu1-mesa-dev \
#  libgnome-keyring-dev \
#  libgnome-keyring0 \
#  libgtk-3-0 \
#  libgtk-3-dev \
#  libgtk2.0-0 \
#  libgtk2.0-dev \
#  libjpeg-dev \
#  libkrb5-dev \
#  libnspr4 \
#  libnspr4-dev \
#  libnss3 \
#  libnss3-dev \
#  libpam0g \
#  libpam0g-dev \
#  libpango1.0-0 \
#  libpci-dev \
#  libpci3 \
#  libpcre3 \
#  libpixman-1-0 \
#  libpng16-16 \
#  libpulse-dev \
#  libpulse0 \
#  libsctp-dev \
#  libspeechd-dev \
#  libspeechd2 \
#  libsqlite3-0 \
#  libsqlite3-dev \
#  libssl-dev \
#  libstdc++6 \
#  libtinfo-dev \
#  libtool \
#  libudev-dev \
#  libudev1 \
#  libwww-perl \
#  libx11-6 \
#  libx11-xcb1 \
#  libxau6 \
#  libxcb1 \
#  libxcomposite1 \
#  libxcursor1 \
#  libxdamage1 \
#  libxdmcp6 \
#  libxext6 \
#  libxfixes3 \
#  libxi6 \
#  libxinerama1 \
#  libxkbcommon-dev \
#  libxrandr2 \
#  libxrender1 \
#  libxslt1-dev \
#  libxss-dev \
#  libxt-dev \
#  libxtst-dev \
#  libxtst6 \
#  linux-libc-dev-armhf-cross \
#  locales \
#  openbox \
#  p7zip \
#  patch \
#  perl \
#  php7.0-cgi \
#  pkg-config \
#  python \
#  python-cherrypy3 \
#  python-crypto \
#  python-dev \
#  python-numpy \
#  python-opencv \
#  python-openssl \
#  python-psutil \
#  python-yaml \
#  realpath \
#  rpm \
#  ruby \
#  subversion \
#  texinfo \
#  wdiff \
#  x11-utils \
#  xcompmgr \
#  xsltproc \
#  xutils-dev \
#  xvfb \
#  zip \
#  zlib1g

RUN apt-get install -y --reinstall \
  ant \
  apache2-bin \
  autoconf \
  binutils-aarch64-linux-gnu \
  binutils-arm-linux-gnueabihf \
  binutils-mips64el-linux-gnuabi64 \
  binutils-mipsel-linux-gnu \
  bison \
  build-essential \
  ca-certificates \
  cdbs \
  cmake \
  curl \
  dbus-x11 \
  devscripts \
  dpkg-dev \
  elfutils \
  fakeroot \
  flex \
  fonts-ipafont \
  g++ \
  g++-6-arm-linux-gnueabihf \
  g++-arm-linux-gnueabihf \
  g++-mingw-w64-i686 \
  gawk \
  gcc \
  gcc-arm-linux-gnueabihf \
  git \
  git-core \
  git-svn \
  gperf \
  intltool \
  lib32ncurses5-dev \
  lib32z1-dev \
  libapache2-mod-php7.0 \
  libappindicator-dev \
  libappindicator1 \
  libappindicator3-1 \
  libappindicator3-dev \
  libasound2 \
  libasound2-dev \
  libasound2:i386 \
  libatk1.0-0 \
  libav-tools \
  libbluetooth-dev \
  libbrlapi-dev \
  libbrlapi0.6 \
  libbz2-1.0 \
  libbz2-dev \
  libc6 \
  libc6-dev-armhf-cross \
  libcairo2 \
  libcairo2-dev \
  libcap-dev \
  libcap2 \
  libcap2:i386 \
  libcups2 \
  libcups2-dev \
  libcurl4-gnutls-dev \
  libdrm-dev \
  libelf-dev \
  libelf-dev:i386 \
  libexpat1 \
  libffi-dev \
  libffi6 \
  libfontconfig1 \
  libfontconfig1:i386 \
  libfreetype6 \
  libgbm-dev \
  libglib2.0-0 \
  libglib2.0-0:i386 \
  libglib2.0-dev \
  libglu1-mesa-dev \
  libgnome-keyring-dev \
  libgnome-keyring0 \
  libgpm2:i386 \
  libgtk-3-0 \
  libgtk-3-0:i386 \
  libgtk-3-dev \
  libgtk2.0-0 \
  libgtk2.0-0:i386 \
  libgtk2.0-dev \
  libjpeg-dev \
  libkrb5-dev \
  libncurses5:i386 \
  libnspr4 \
  libnspr4-dev \
  libnss3 \
  libnss3-dev \
  libnss3:i386 \
  libpam0g \
  libpam0g-dev \
  libpango1.0-0 \
  libpango1.0-0:i386 \
  libpci-dev \
  libpci3 \
  libpci3:i386 \
  libpcre3 \
  libpixman-1-0 \
  libpng16-16 \
  libpq-dev \
  libpulse-dev \
  libpulse0 \
  libsctp-dev \
  libspeechd-dev \
  libspeechd2 \
  libsqlite3-0 \
  libsqlite3-dev \
  libssl-dev \
  libssl-dev:i386 \
  libssl1.1:i386 \
  libstdc++6 \
  libstdc++6 \
  libtinfo-dev \
  libtinfo-dev:i386 \
  libtool \
  libudev-dev \
  libudev1 \
  libudev1:i386 \
  libwww-perl \
  libx11-6 \
  libx11-xcb1 \
  libxau6 \
  libxcb1 \
  libxcomposite1 \
  libxcomposite1:i386 \
  libxcursor1 \
  libxcursor1:i386 \
  libxdamage1 \
  libxdamage1:i386 \
  libxdmcp6 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxi6:i386 \
  libxinerama1 \
  libxkbcommon-dev \
  libxrandr2 \
  libxrandr2:i386 \
  libxrender1 \
  libxslt1-dev \
  libxss-dev \
  libxss1:i386 \
  libxt-dev \
  libxtst-dev \
  libxtst6 \
  libxtst6:i386 \
  linux-libc-dev-armhf-cross \
  linux-libc-dev:i386 \
  locales \
  make \
  openbox \
  p7zip \
  patch \
  perl \
  php7.0-cgi \
  pkg-config \
  postgresql-common \
  postgresql-server-dev-$PG_MAJOR \
  python \
  python-cherrypy3 \
  python-crypto \
  python-dev \
  python-numpy \
  python-opencv \
  python-openssl \
  python-pip \
  python-psutil \
  python-yaml \
  realpath \
  rpm \
  ruby \
  subversion \
  texinfo \
  wdiff \
  x11-utils \
  xcompmgr \
  xsltproc \
  xutils-dev \
  xvfb \
  zip \
  zlib1g

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
