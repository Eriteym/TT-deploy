#!/bin/bash
set -e

# see
# https://www.cybertec-postgresql.com/en/3-ways-to-detect-slow-queries-in-postgresql/
# for details and debugging

cat << EOF >>/var/lib/postgresql/data/postgresql.conf

# report slow queries
log_min_duration_statement = 1000

session_preload_libraries = 'auto_explain'
auto_explain.log_analyze = 1
auto_explain.log_min_duration = '1s'
auto_explain.log_nested_statements = 1
auto_explain.sample_rate = 1

EOF
