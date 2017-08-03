FROM abakpress/knife-base

# Ignore configuration requests
ENV POSTGRESQL_VERSION 9.5
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
  apt-get -qq update && \
  apt-get -y -q upgrade && \
  apt-get -y -q install \
  sudo \
  postgresql-${POSTGRESQL_VERSION} \
  postgresql-client-${POSTGRESQL_VERSION} \
  postgresql-plperl-${POSTGRESQL_VERSION} \
  postgresql-contrib-${POSTGRESQL_VERSION} \
  skytools3 \
  postgresql-${POSTGRESQL_VERSION}-pgq3 \
  skytools3-ticker && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN /etc/init.d/postgresql start &&\
  while ps aux | grep "postgres: [s]tartup process" > /dev/null; do sleep 1;done &&\
  setuser postgres psql -c "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
  setuser postgres createdb docker -O docker docker &&\
  /etc/init.d/postgresql stop &&\
  echo "data_directory='/data'" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf && \
  mkdir /etc/service/postgresql

ADD postgresql.conf /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf

ADD db/consul.json /etc/consul/conf.d/postgresql.json

# entrypoint
ADD db/postgresql.sh /etc/service/postgresql/run

ENV CONSUL_HOST=consul

VOLUME ["/data"]
EXPOSE 5432