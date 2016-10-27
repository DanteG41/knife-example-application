FROM devopsftw/baseimage:dev

ENV DEBIAN_FRONTEND=noninteractive

# ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8

ENV APP_PATH /var/app
ENV RAILS_ENV production
ENV CONSUL_HOST consul

# install ruby
RUN apt-get update -qq
RUN apt-get install -y libssl-dev libgmp3-dev ruby ruby-dev openssl make gcc g++ openssl \
    postgresql-client libpq-dev

WORKDIR $APP_PATH

COPY app/src/Gemfile.lock app/src/Gemfile $APP_PATH/

RUN gem install bundler
RUN bundle install --deployment --without 'test development debug' -j 4



COPY app/services/puma.sh /etc/service/puma/run
COPY app/consul.json /etc/consul/conf.d/app.json

EXPOSE 3000