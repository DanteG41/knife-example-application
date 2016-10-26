FROM devopsftw/baseimage:dev

ENV DEBIAN_FRONTEND=noninteractive

# ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8

ENV APP_PATH /var/app
ENV RAILS_ENV production
ENV CONSUL_HOST consul

# install ruby
ENV RVM_PATH /usr/local/rvm
ENV RVM ${RVM_PATH}/bin/rvm
ENV RVM_RUBY ruby-2.2.5
ENV PATH ${RVM_PATH}/rubies/${RVM_RUBY}/bin:$PATH
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -L https://get.rvm.io | bash -s stable && \
  $RVM install $RVM_RUBY


WORKDIR $APP_PATH

COPY app/src/Gemfile.lock ./Gemfile $APP_PATH/

RUN gem install bundler && \
  bundle install --deployment --without 'test development debug' -j 4

COPY app/src/* $APP_PATH/

COPY app/services/puma.sh /etc/service/puma/run
COPY app/consul.json /etc/consul/conf.d/app.json

EXPOSE 3000