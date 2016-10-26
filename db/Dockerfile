FROM devopsftw/baseimage:dev

# Ignore configuration requests
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  apt-get -qq update && apt-get -q -y upgrade && apt-get install -y -q \
  postgresql-9.5 \
  postgresql-client-9.5 \
  postgresql-contrib-9.5 \
  libpq-dev \
  python-software-properties \
  software-properties-common

RUN /etc/init.d/postgresql start &&\
  while ps aux | grep "postgres: [s]tartup process" > /dev/null; do sleep 1;done &&\
  setuser postgres psql -c "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
  setuser postgres createdb docker -O docker docker &&\
  /etc/init.d/postgresql stop

ADD postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
ADD consul.conf /etc/consul/conf.d/postgresql.conf

# entrypoint
ADD postgresql.sh /etc/service/postgresql/run

ENV CONSUL_HOST=consul

VOLUME ["/data"]
EXPOSE 5432