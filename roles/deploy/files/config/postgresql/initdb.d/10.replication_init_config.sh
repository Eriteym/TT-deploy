#!/bin/bash
set -e

# see for example:
# https://github.com/DanielDent/docker-postgres-replication/

cat >> ${PGDATA}/postgresql.conf <<EOF

wal_level = hot_standby
max_wal_senders = ${PG_MAX_WAL_SENDERS:-8}
wal_keep_segments = ${PG_WAL_KEEP_SEGMENTS:-32}
hot_standby = on

EOF

# grep wal ${PGDATA}/postgresql.conf
