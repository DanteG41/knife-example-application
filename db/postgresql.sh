#!/bin/bash
set -x
touch /data/PG_VERSION && echo 9.5 >> /data/PG_VERSION
chmod -R 700 /data
chown -R postgres:postgres /data
exec /sbin/setuser postgres /usr/lib/postgresql/9.5/bin/postgres --config-file=/etc/postgresql/9.5/main/postgresql.conf