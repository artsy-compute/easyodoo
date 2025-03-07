#!/bin/bash

set -e

if [ -v PASSWORD_FILE ]; then
    POSTGRES_PASSWORD="$(< $PASSWORD_FILE)"
fi

# set the postgres database host, port, user and password according to the environment
# and pass them as arguments to the odoo process if not present in the config file
: ${HOST:=${DB_PORT_5432_TCP_ADDR:='127.0.0.1'}}
: ${PORT:=${DB_PORT_5432_TCP_PORT:=5432}}
: ${USER:=${DB_ENV_POSTGRES_USER:=${POSTGRES_USER:='odoo'}}}
: ${PASSWORD:=${DB_ENV_POSTGRES_PASSWORD:=${POSTGRES_PASSWORD:='odoo'}}}

DB_ARGS=()

: ${ODOO_CMD_ARGS:=${ODOO_CMD_ARGS:=''}}

echo "ODOO_CMD_ARGS="\'$ODOO_CMD_ARGS\'

CONFIG_FILE="/etc/odoo/odoo.conf"

function check_config() {
    param="$1"
    value="$2"
    if grep -q -E "^\s*\b${param}\b\s*=" "$CONFIG_FILE" ; then
        value=$(grep -E "^\s*\b${param}\b\s*=" "$CONFIG_FILE" |cut -d " " -f3|sed 's/["\n\r]//g')
    fi;
    DB_ARGS+=("--${param}")
    DB_ARGS+=("${value}")
}
check_config "db_host" "$HOST"
check_config "db_port" "$PORT"
check_config "db_user" "$USER"
check_config "db_password" "$PASSWORD"

case "$1" in
    -- | odoo)
        shift
        if [[ "$1" == "scaffold" ]] ; then
            exec odoo "$@" --config=$CONFIG_FILE
        else
            wait-for-psql.py ${DB_ARGS[@]} --timeout=30
            exec odoo "$@" "${DB_ARGS[@]}" --config=$CONFIG_FILE $ODOO_CMD_ARGS
        fi
        ;;
    -*)
        wait-for-psql.py ${DB_ARGS[@]} --timeout=30
        exec odoo "$@" "${DB_ARGS[@]}" --config=$CONFIG_FILE $ODOO_CMD_ARGS
        ;;
    *)
        exec "$@" --config=$CONFIG_FILE $ODOO_CMD_ARGS
esac

exit 1
