#!/bin/bash

set -e

SCRIPTSRC=`readlink -f "$0" || echo "$0"`
SCRIPT_PATH=`dirname "$SCRIPTSRC" || echo .`
NOW=$(date +"%Y%m%d-%H%M%S")
DATA_FOLDER=${SCRIPT_PATH}/../config/authservice

[ ! -d ${DATA_FOLDER} ] && mkdir -p ${DATA_FOLDER}

# $SCRIPT_PATH/jwt.create_config.sh

if [ ! -f "${DATA_FOLDER}/jwt.conf" ]; then
  echo "! no config file found: '${DATA_FOLDER}/jwt.conf'"
  exit 1
fi
. "${DATA_FOLDER}/jwt.conf"

if [ -f ${DATA_FOLDER}/keystore.jks ]; then
  if  [ ! -z "${FORCE}" ]; then
    echo "* backup existing certificate: ${DATA_FOLDER}/keystore.jks-backup-${NOW}"
    mv ${DATA_FOLDER}/keystore.jks ${DATA_FOLDER}/keystore.jks-backup-${NOW}
  else
    echo "* certificate file ${DATA_FOLDER}/keystore.jks already exists - skip generation"
    exit 0
  fi
fi

# generate certificate for JWT token
keytool \
	-genkeypair \
	-keyalg RSA \
	-storetype JKS \
	-keystore ${DATA_FOLDER}/keystore.jks \
	-storepass "${KEYSTORE_PASS}" \
	-alias authservice \
	-keypass "${KEYPASS_AUTHSERVICE}" \
	-validity 1095 -keysize 2048 \
	-dname "${DNAME}"
echo "* created certificate file: ${DATA_FOLDER}/keystore.jks"

rm ${DATA_FOLDER}/cert.*.crt >/dev/null 2>&1
rm ${DATA_FOLDER}/cert.*.pub >/dev/null 2>&1
