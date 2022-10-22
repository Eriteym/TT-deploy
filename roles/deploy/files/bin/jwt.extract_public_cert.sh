#!/bin/bash

set -e

SCRIPTSRC=`readlink -f "$0" || echo "$0"`
SCRIPT_PATH=`dirname "$SCRIPTSRC" || echo .`
DATA_FOLDER=${SCRIPT_PATH}/../config/authservice

. ${SCRIPT_PATH}/args.sh "$@"

if [ ! -f "${DATA_FOLDER}/jwt.conf" ]; then
  echo "* no config file found: '${DATA_FOLDER}/jwt.conf'"
  exit 1
fi
. "$DATA_FOLDER/jwt.conf"

[ ! -d ${DATA_FOLDER} ] && (echo "create certificates folder: ${DATA_FOLDER} ";  mkdir -p ${DATA_FOLDER})

# generate
keytool -export -keystore ${DATA_FOLDER}/keystore.jks -alias authservice -storepass "${KEYSTORE_PASS}" -file ${DATA_FOLDER}/keystore.crt
openssl x509 -inform der -in ${DATA_FOLDER}/keystore.crt -pubkey -noout > ${DATA_FOLDER}/keystore.pub

# clean
rm ${DATA_FOLDER}/keystore.crt
