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

RUN echo "host all all 127.0.0.1/32 trust" > /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf && \
  echo "host all all ::1/128 trust" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf && \
  echo "local all all trust" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf && \
  echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/pg_hba.conf && \
  echo "listen_addresses='*'" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf && \
  echo "ssl=false" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf && \
  echo "plperl.on_init = 'use utf8; use re; package utf8; require \"utf8_heavy.pl\";'" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf

RUN /etc/init.d/postgresql start &&\
  while ps aux | grep "postgres: [s]tartup process" > /dev/null; do sleep 1;done &&\
  setuser postgres psql -c "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
  setuser postgres createdb docker -O docker docker &&\
  /etc/init.d/postgresql stop &&\
  echo "data_directory='/data'" >> /etc/postgresql/${POSTGRESQL_VERSION}/main/postgresql.conf && \
  mkdir /etc/service/postgresql

ADD db/consul.json /etc/consul/conf.d/postgresql.json

# entrypoint
ADD db/postgresql.sh /etc/service/postgresql/run

ENV CONSUL_HOST=consul

VOLUME ["/data"]
EXPOSE 5432