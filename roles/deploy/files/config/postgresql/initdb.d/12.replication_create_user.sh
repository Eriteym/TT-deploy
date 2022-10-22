#!/bin/bash
set -e

function generate_password() {
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
}

if [ -z ${POSTGRES_REPLICA_PASSWORD} ]; then
  POSTGRES_REPLICA_PASSWORD=$(generate_password)
  echo "Postgresql replica user password: ${POSTGRES_REPLICA_PASSWORD}"
fi

createuser -U ${POSTGRES_USER:-timetracker} ${POSTGRES_REPLICA_USER:-replicator} -c ${PG_MAX_WAL_SENDERS:-5} --replication
psql -U ${POSTGRES_USER:timetracker} -d postgres -c "ALTER USER ${POSTGRES_REPLICA_USER:-replicator} WITH PASSWORD '${POSTGRES_REPLICA_PASSWORD:-replicator}' "
