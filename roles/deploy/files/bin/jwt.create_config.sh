#!/bin/bash

set -e

SCRIPTSRC=`readlink -f "$0" || echo "$0"`
SCRIPT_PATH=`dirname "$SCRIPTSRC" || echo .`
NOW=$(date +"%Y%m%d-%H%M%S")
DATA_FOLDER=${SCRIPT_PATH}/../config/authservice

. ${SCRIPT_PATH}/args.sh "$@"

function generatePassword() {
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
}

# backup
if [ -f ${DATA_FOLDER}/jwt.conf ]; then
  if  [ ! -z "${FORCE}" ]; then
    echo "* backup existing configuration: ${DATA_FOLDER}/jwt.conf-backup-${NOW}"
    mv ${DATA_FOLDER}/jwt.conf ${DATA_FOLDER}/jwt.conf-backup-${NOW}
  else
    echo "* config file ${DATA_FOLDER}/jwt.conf already exists - skip generation"
    exit 0
  fi
fi

cp ${DATA_FOLDER}/jwt.conf.sample ${DATA_FOLDER}/jwt.conf

KEYSTORE_PASS=$(generatePassword)
KEYPASS_AUTHSERVICE=$(generatePassword)

echo "* key store password: ${KEYSTORE_PASS}"
echo "* auth service certificate password: ${KEYPASS_AUTHSERVICE}"

sed -i \
    -e "s#KEYSTORE_PASS=.*#KEYSTORE_PASS=${KEYSTORE_PASS}#g" \
    -e "s#KEYPASS_AUTHSERVICE=.*#KEYPASS_AUTHSERVICE=${KEYPASS_AUTHSERVICE}#g" \
    "${DATA_FOLDER}/jwt.conf"
echo "* created certificate config file: ${DATA_FOLDER}/jwt.conf"

sed -i.backup--${NOW} \
    -e "s#AUTHSERVICE_KEYSTORE_PASSWORD=.*#AUTHSERVICE_KEYSTORE_PASSWORD=${KEYSTORE_PASS}#g" \
    -e "s#AUTHSERVICE_KEYSTORE_GWT_PASSWORD=.*#AUTHSERVICE_KEYSTORE_GWT_PASSWORD=${KEYPASS_AUTHSERVICE}#g" \
    "${SCRIPT_PATH}/../.env_authservice"
echo "* updated config file: ${SCRIPT_PATH}/../.env_authservice"
