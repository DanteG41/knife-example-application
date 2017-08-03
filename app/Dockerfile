FROM index.exp.railsc.ru/knife-example-application_knife-example-app_base

COPY app/src/ $APP_PATH/
RUN bundle install --deployment --without 'test development debug' -j 4
