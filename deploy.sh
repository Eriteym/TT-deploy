#!/bin/sh

SCRIPTSRC=`readlink -f "$0" || echo "$0"`
SCRIPT_PATH=`dirname "$SCRIPTSRC" || echo .`

. ${SCRIPT_PATH}/config.sh

ansible-playbook -u "$DEPLOY_USER" -i hosts -e 'ansible_python_interpreter=/usr/bin/python3' deploy.yml
