#!/bin/bash
set -e

# see for example:
# https://github.com/DanielDent/docker-postgres-replication/

cat >> ${PGDATA}/pg_hba.conf <<EOF

host replication all 0.0.0.0/0 ${POSTGRES_HOST_AUTH_METHOD:-md5}
# host all all 0.0.0.0/0 ${POSTGRES_HOST_AUTH_METHOD:-md5}

EOF

# grep host ${PGDATA}/pg_hba.conf
