#!/usr/bin/env bash

set +e

cd $APP_PATH
exec bin/rake db:create db:migrate