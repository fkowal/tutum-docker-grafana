#!/bin/bash

set -e

INFLUXDB_HOST=${INFLUXDB_PORT_8086_TCP_ADDR:-${INFLUXDB_HOST}}
INFLUXDB_HOST=${INFLUXDB_1_PORT_8086_TCP_ADDR:-${INFLUXDB_HOST}}
INFLUXDB_PORT=${INFLUXDB_PORT_8086_TCP_PORT:-${INFLUXDB_PORT}}
INFLUXDB_PORT=${INFLUXDB_1_PORT_8086_TCP_PORT:-${INFLUXDB_PORT}}
INFLUXDB_PASS=${INFLUXDB_ENV_INFLUXDB_INIT_PWD:-${INFLUXDB_PASS}}
INFLUXDB_PASS=${INFLUXDB_1_ENV_INFLUXDB_INIT_PWD:-${INFLUXDB_PASS}}

ELASTICSEARCH_HOST=${ELASTICSEARCH_PORT_9200_TCP_ADDR:-${ELASTICSEARCH_HOST}}
ELASTICSEARCH_HOST=${ELASTICSEARCH_1_PORT_9200_TCP_ADDR:-${ELASTICSEARCH_HOST}}
ELASTICSEARCH_PORT=${ELASTICSEARCH_PORT_9200_TCP_PORT:-${ELASTICSEARCH_PORT}}
ELASTICSEARCH_PORT=${ELASTICSEARCH_1_PORT_9200_TCP_PORT:-${ELASTICSEARCH_PORT}}

if [ "${ELASTICSEARCH_HOST}" = "**LinkMe**" ]; then
    unset ELASTICSEARCH_HOST
fi

if [ "${ELASTICSEARCH_PORT}" = "**LinkMe**" ]; then
    unset ELASTICSEARCH_PORT
fi

if [ "${HTTP_PASS}" = "**Random**" ]; then
    unset HTTP_PASS
fi


if [ ! -f /.basic_auth_configured ]; then
    /set_basic_auth.sh
fi

# if [ ! -f /.influx_db_configured ]; then
#     /set_influx_db.sh
# fi

if [ ! -f /.graphite_configured ]; then
    /set_graphite.sh
fi

if [ ! -f /.elasticsearch_configured ]; then
    /set_elasticsearch.sh
fi

echo "=> Starting and running Nginx..."
/usr/sbin/nginx
