#!/bin/bash
set -e

# see
# https://www.postgresql.org/docs/current/pgstatstatements.html
# for details

cat >> ${PGDATA}/postgresql.conf <<EOF

shared_preload_libraries = 'pg_stat_statements'

pg_stat_statements.max = 10000
pg_stat_statements.track = all

EOF

echo '*** Please execute:'
echo CREATE EXTENSION pg_stat_statements;
echo after system restart
